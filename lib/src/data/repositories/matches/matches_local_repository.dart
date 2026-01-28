import 'package:matchmaker/src/app_database.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart' hide Session;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'matches_repository.dart';

class MatchesLocalRepository implements MatchesRepository {
  late final Database _db;
  late final Session? _session;

  MatchesLocalRepository(AppDatabase app) {
    _db = app.local;
    _session = app.remote.auth.currentSession;
  }

  @override
  AsyncResult<MatchEntity> insertOne(InsertOneMatchParams params) async {
    final userId = _session?.user.id;

    if (userId == null) {
      return Result.error(Exception('Usuário não autenticado!'));
    }

    final result0 = _db.select(
      'INSERT INTO tb_event_matches (user_id, event_id, name, first_team_id, second_team_id, max_score, half_score_to_eliminate) VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING *',
      [
        userId,
        params.eventId,
        params.name,
        params.firstTeamId,
        params.secondTeamId,
        params.maxScore,
        params.halfScoreToEliminate,
      ],
    );

    if (result0.isEmpty) {
      return Result.error(Exception('Match not found'));
    }

    final result1 = _db.select('SELECT queue FROM tb_events WHERE id = ?', [params.eventId]);

    final queue = (result1.first['queue'] as String).split(',').map(int.parse).toList();

    params.dequeue.forEach(queue.remove);

    if (params.enqueue.length == 2) {
      queue.insert(0, params.enqueue.first);
      queue.add(params.enqueue.last);
    } else {
      queue.add(params.enqueue.first);
    }

    _db.execute('UPDATE tb_events SET queue = ? WHERE id = ?', [queue.join(','), params.eventId]);

    final match = MatchEntity.fromSqlite(result0[0]);

    return findOne(match.id);
  }

  @override
  AsyncResult<MatchEntity> findOne(int id) async {
    final result = _db.select(
      'SELECT * FROM vw_event_match_full WHERE id = ? ORDER BY created_at DESC',
      [id],
    );

    if (result.isEmpty) {
      return Result.error(Exception('Match not found'));
    }

    return Result.ok(MatchEntity.fromSqlite(result[0]));
  }

  @override
  AsyncResult<MatchEntity> updateOne(int id, UpdateOneMatchParams params) async {
    final values = <String, dynamic>{
      if (params.name != null) 'name': params.name,
      if (params.maxScore != null) 'max_score': params.maxScore,
      if (params.halfScoreToEliminate != null) 'half_score_to_eliminate': params.halfScoreToEliminate == true ? 1 : 0,
      if (params.ended != null) 'ended': params.ended == true ? 1 : 0,
      if (params.ended != null && params.ended == true) 'ended_at': DateTime.now().toIso8601String(),
    };

    if (values.isEmpty) {
      return Result.error(Exception('No values to update'));
    }

    values['updated_at'] = DateTime.now().toIso8601String();

    _db.select(
      'UPDATE tb_event_matches SET ${values.keys.map((key) => '$key = ?').join(', ')} WHERE id = ? RETURNING *',
      [
        ...values.values,
        id,
      ],
    );

    return findOne(id);
  }

  @override
  AsyncResult<MatchEntity> updateManyByEventId(int eventId, UpdateOneMatchParams params) async {
    try {
      final values = <String, dynamic>{
        if (params.name != null) 'name': params.name,
        if (params.maxScore != null) 'max_score': params.maxScore,
        if (params.halfScoreToEliminate != null) 'half_score_to_eliminate': params.halfScoreToEliminate == true ? 1 : 0,
        if (params.ended != null) 'ended': params.ended == true ? 1 : 0,
        if (params.ended != null && params.ended == true) 'ended_at': DateTime.now().toIso8601String(),
      };

      if (values.isEmpty) {
        return Result.error(Exception('No values to update'));
      }

      values['updated_at'] = DateTime.now().toIso8601String();

      _db.select(
        'UPDATE tb_event_matches SET ${values.keys.map((key) => '$key = ?').join(', ')} WHERE event_id = ?',
        [
          ...values.values,
          eventId,
        ],
      );

      return findOne(eventId);
    } on SqliteException catch (e) {
      return Result.error(e);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  AsyncResult<void> deleteOne(int id) async {
    try {
      _db.execute('DELETE FROM tb_event_matches WHERE id = ?', [id]);
      return const Result.ok(null);
    } on SqliteException catch (e) {
      return Result.error(e);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  AsyncResult<void> deleteManyByEventId(int eventId) async {
    try {
      _db.execute('DELETE FROM tb_event_matches WHERE event_id = ?', [eventId]);
      return const Result.ok(null);
    } on SqliteException catch (e) {
      return Result.error(e);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
