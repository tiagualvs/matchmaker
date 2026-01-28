import 'package:matchmaker/src/app_database.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart' hide Session;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'events_repository.dart';

class EventsLocalRepository implements EventsRepository {
  late final Session? _session;
  late final Database _db;

  EventsLocalRepository(AppDatabase app) {
    _session = app.remote.auth.currentSession;
    _db = app.local;
  }

  @override
  AsyncResult<List<EventEntity>> findMany() async {
    final result = _db.select('SELECT * FROM vw_events_full ORDER BY created_at DESC');

    return Result.ok(result.map(EventEntity.fromSqlite).toList());
  }

  @override
  AsyncResult<EventEntity> findOne(int id) async {
    final result = _db.select('SELECT * FROM vw_events_full WHERE id = ?', [id]);

    if (result.isEmpty) {
      return Result.error(Exception('Event not found'));
    }

    return Result.ok(EventEntity.fromSqlite(result.first));
  }

  @override
  AsyncResult<EventEntity> insertOne(InsertOneEventParams params) async {
    final userId = _session?.user.id;

    if (userId == null) {
      return Result.error(Exception('Você precisa estar autenticado para realizar esta ação!'));
    }

    final result0 = _db.select(
      'INSERT INTO tb_events (user_id, name, max_score, half_score_to_eliminate, max_player_per_team, balanced_by_gender, balanced_by_level, max_wins_in_a_row) VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING *',
      [
        userId,
        params.name,
        params.maxScore,
        params.halfScoreToEliminate ? 1 : 0,
        params.maxPlayerPerTeam,
        params.balancedByGender ? 1 : 0,
        params.balancedByLevel ? 1 : 0,
        params.maxWinsInARow,
      ],
    );

    final event = EventEntity.fromSqlite(result0.first);

    final teams = <TeamEntity>[];

    for (final t in params.teams) {
      final result1 = _db.select(
        'INSERT INTO tb_event_teams (user_id, event_id, name) VALUES (?, ?, ?) RETURNING *',
        [userId, event.id, t.name],
      );

      final team = TeamEntity.fromSqlite(result1.first);

      final players = <PlayerEntity>[];

      for (final p in t.players) {
        final result2 = _db.select(
          'INSERT INTO tb_players (user_id, name, gender, level) VALUES (?, ?, ?, ?) ON CONFLICT(name) DO UPDATE SET name = excluded.name RETURNING *',
          [userId, p.name, p.gender.value, p.level.value],
        );

        final player = PlayerEntity.fromSqlite(result2.first);

        _db.execute(
          'INSERT INTO tb_event_team_players (user_id, team_id, player_id) VALUES (?, ?, ?)',
          [userId, team.id, player.id],
        );

        players.add(player);
      }

      teams.add(team.copyWith(players: players));
    }

    final starterTeams = teams.take(2);

    final result3 = _db.select(
      'INSERT INTO tb_event_matches (user_id, name, event_id, first_team_id, second_team_id, max_score, half_score_to_eliminate) VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING *',
      [
        userId,
        'Partida #1',
        event.id,
        starterTeams.first.id,
        starterTeams.last.id,
        event.maxScore,
        event.halfScoreToEliminate ? 1 : 0,
      ],
    );

    final match = MatchEntity.fromSqlite(result3.first);

    final enqueue = teams.skip(2).map((team) => team.id).toList();

    _db.execute('UPDATE tb_events SET queue = ? WHERE id = ?', [enqueue.join(','), event.id]);

    return Result.ok(
      event.copyWith(
        teams: teams,
        matches: [match],
        queue: enqueue,
      ),
    );
  }

  @override
  AsyncResult<EventEntity> updateOne(int id, UpdateOneEventParams params) async {
    final values = <String, dynamic>{
      if (params.name != null) 'name': params.name,
      if (params.maxScore != null) 'max_score': params.maxScore,
      if (params.halfScoreToEliminate != null) 'half_score_to_eliminate': params.halfScoreToEliminate == true ? 1 : 0,
      if (params.maxPlayerPerTeam != null) 'max_player_per_team': params.maxPlayerPerTeam,
      if (params.balancedByGender != null) 'balanced_by_gender': params.balancedByGender == true ? 1 : 0,
      if (params.balancedByLevel != null) 'balanced_by_level': params.balancedByLevel == true ? 1 : 0,
      if (params.maxWinsInARow != null) 'max_wins_in_a_row': params.maxWinsInARow,
      if (params.ended != null) 'ended': params.ended == true ? 1 : 0,
      if (params.ended != null && params.ended == true) 'ended_at': DateTime.now().toIso8601String(),
    };

    if (values.isEmpty) {
      return Result.error(Exception('Nenhum campo para atualizar!'));
    }

    final result = _db.select(
      'UPDATE tb_events SET ${values.keys.map((key) => '$key = ?').join(', ')} WHERE id = ? RETURNING *',
      [...values.values, id],
    );

    return Result.ok(EventEntity.fromSqlite(result.first));
  }
}
