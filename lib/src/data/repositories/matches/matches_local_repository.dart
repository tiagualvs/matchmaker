import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart';

import 'matches_repository.dart';

class MatchesLocalRepository implements MatchesRepository {
  final Database _db;

  const MatchesLocalRepository(this._db);

  @override
  AsyncResult<MatchEntity> insertOne(InsertOneMatchParams params) async {
    final result = _db.select(
      'INSERT INTO tb_event_matches (event_id, name, first_team_id, second_team_id, max_score) VALUES (?, ?, ?, ?, ?) RETURNING *',
      [
        params.eventId,
        params.name,
        params.firstTeamId,
        params.secondTeamId,
        params.maxScore,
      ],
    );

    if (result.isEmpty) {
      return Result.error(Exception('Match not found'));
    }

    _db.execute('DELETE FROM tb_event_queue WHERE team_id = ?', [params.dequeue]);

    _db.execute('INSERT INTO tb_event_queue (event_id, team_id) VALUES (?, ?)', [
      params.eventId,
      params.enqueue,
    ]);

    final match = MatchEntity.fromSqlite(result[0]);

    return findOne(match.id);
  }

  @override
  AsyncResult<MatchEntity> findOne(int id) async {
    final result = _db.select(
      'SELECT * FROM vw_event_match_full WHERE id = ?',
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
      if (params.ended != null) 'ended': params.ended == true ? 1 : 0,
      if (params.endedAt != null) 'ended_at': params.endedAt?.toIso8601String(),
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
}
