import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart';

import 'events_repository.dart';

class EventsLocalRepository implements EventsRepository {
  final Database _db;

  const EventsLocalRepository(this._db);

  @override
  AsyncResult<List<EventEntity>> findMany() async {
    final result = _db.select('SELECT * FROM vw_events_full');

    return Result.ok(result.map(EventEntity.fromSqlite).toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt)));
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
    final result0 = _db.select(
      'INSERT INTO tb_events (name, max_score, max_player_per_team) VALUES (?, ?, ?) RETURNING *',
      [params.name, params.maxScore, params.maxPlayerPerTeam],
    );

    final event = EventEntity.fromSqlite(result0.first);

    final teams = <TeamEntity>[];

    for (final t in params.teams) {
      final result1 = _db.select(
        'INSERT INTO tb_event_teams (event_id, name) VALUES (?, ?) RETURNING *',
        [event.id, t.name],
      );

      final team = TeamEntity.fromSqlite(result1.first);

      final players = <PlayerEntity>[];

      for (final p in t.players) {
        final result2 = _db.select(
          'INSERT INTO tb_players (name, gender, level) VALUES (?, ?, ?) ON CONFLICT(name) DO UPDATE SET name = excluded.name RETURNING *',
          [p.name, p.gender.value, p.level.value],
        );

        final player = PlayerEntity.fromSqlite(result2.first);

        _db.execute(
          'INSERT INTO tb_event_team_players (team_id, player_id) VALUES (?, ?)',
          [team.id, player.id],
        );

        players.add(player);
      }

      teams.add(team.copyWith(players: players));
    }

    final starterTeams = teams.take(2);

    final result3 = _db.select(
      'INSERT INTO tb_event_matches (name, event_id, first_team_id, second_team_id, max_score) VALUES (?, ?, ?, ?, ?) RETURNING *',
      ['Partida #1', event.id, starterTeams.first.id, starterTeams.last.id, event.maxScore],
    );

    final match = MatchEntity.fromSqlite(result3.first);

    for (final team in teams.skip(2)) {
      _db.execute(
        'INSERT INTO tb_event_queue (event_id, team_id) VALUES (?, ?)',
        [event.id, team.id],
      );
    }

    return Result.ok(
      event.copyWith(
        teams: teams,
        matches: [match],
        queue: teams.skip(2).map((team) => team.id).toList(),
      ),
    );
  }
}
