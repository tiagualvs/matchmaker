import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/v7.dart';

class EventsRepository {
  const EventsRepository(this._db);

  final Database _db;

  AsyncResult<EventEntity> insertOne(EventEntity event) async {
    _db.select(
      'INSERT INTO events (id, name, max_score, max_player_per_team, ended, created_at, updated_at, ended_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [
        event.id,
        event.name,
        event.maxScore,
        event.maxPlayerPerTeam,
        event.ended ? 1 : 0,
        event.createdAt.toUtc().toIso8601String(),
        event.updatedAt.toUtc().toIso8601String(),
        event.endedAt?.toUtc().toIso8601String(),
      ],
    );

    for (final team in event.teams) {
      _db.select(
        'INSERT INTO event_teams (id, name, event_id, created_at, updated_at) VALUES (?, ?, ?, ?, ?)',
        [
          team.id,
          team.name,
          team.eventId,
          team.createdAt.toUtc().toIso8601String(),
          team.updatedAt.toUtc().toIso8601String(),
        ],
      );

      for (final player in team.players) {
        _db.select(
          'INSERT INTO players (id, name, gender, level, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)',
          [
            player.id,
            player.name,
            player.gender.value,
            player.level.value,
            player.createdAt.toUtc().toIso8601String(),
            player.updatedAt.toUtc().toIso8601String(),
          ],
        );

        _db.select(
          'INSERT INTO team_players (id, team_id, player_id) VALUES (?, ?, ?)',
          [
            const UuidV7().generate(),
            team.id,
            player.id,
          ],
        );
      }
    }

    final teams = event.teams.take(2);

    final match = MatchEntity.create(
      eventId: event.id,
      name: '${teams.first.name} vs ${teams.last.name}',
      firstTeam: teams.first,
      secondTeam: teams.last,
      maxScore: event.maxScore,
    );

    _db.select(
      'INSERT INTO event_matches (id, name, event_id, first_team_id, second_team_id, max_score, ended, created_at, updated_at, ended_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        match.id,
        match.name,
        match.eventId,
        match.firstTeam.id,
        match.secondTeam.id,
        match.maxScore,
        match.ended ? 1 : 0,
        match.createdAt.toUtc().toIso8601String(),
        match.updatedAt.toUtc().toIso8601String(),
        match.endedAt?.toUtc().toIso8601String(),
      ],
    );

    return Result.ok(event.copyWith(matches: [match]));
  }

  AsyncResult<List<EventEntity>> findMany() async {
    final result = _db.select('SELECT * FROM events ORDER BY created_at DESC;');

    final rawEvents = result.map(EventEntity.fromSqlite).toList();

    final events = <EventEntity>[];

    for (final event in rawEvents) {
      final result = await findOne(event.id);

      if (result.isError) return Result.error(result.failure);

      events.add(result.value);
    }

    return Result.ok(events);
  }

  AsyncResult<EventEntity> findOne(String id) async {
    final result = _db.select(
      'SELECT * FROM events WHERE id = ?',
      [id],
    );

    final event = EventEntity.fromSqlite(result.first);

    final teamsResult = _db.select(
      'SELECT * FROM event_teams WHERE event_id = ?;',
      [event.id],
    );

    final rawTeams = teamsResult.map(TeamEntity.fromSqlite).toList();

    final teams = <TeamEntity>[];

    for (final team in rawTeams) {
      final playersResult = _db.select(
        'SELECT p.* FROM team_players as tp JOIN players as p ON tp.player_id = p.id WHERE tp.team_id = ?',
        [team.id],
      );

      final rawPlayers = playersResult.map(PlayerEntity.fromSqlite).toList();

      teams.add(team.copyWith(players: rawPlayers));
    }

    final matchesResult = _db.select(
      '''SELECT em.*,
        et1.id as first_team_id,
        et1.event_id as first_team_event_id,
        et1.name as first_team_name,
        et1.created_at as first_team_created_at,
        et1.updated_at as first_team_updated_at,
        et2.id as second_team_id,
        et2.event_id as second_team_event_id,
        et2.name as second_team_name,
        et2.created_at as second_team_created_at,
        et2.updated_at as second_team_updated_at
      FROM event_matches as em
      JOIN event_teams as et1 ON em.first_team_id = et1.id
      JOIN event_teams as et2 ON em.second_team_id = et2.id
      WHERE em.event_id = ?;''',
      [event.id],
    );

    final rawMatches = matchesResult.map(MatchEntity.fromSqlite).toList();

    final matches = <MatchEntity>[];

    for (final match in rawMatches) {
      final scoresResult = _db.select(
        'SELECT * FROM match_scores WHERE match_id = ?;',
        [match.id],
      );

      final rawScores = scoresResult.map(ScoreEntity.fromSqlite).toList();

      matches.add(match.copyWith(scores: rawScores));
    }

    return Result.ok(event.copyWith(teams: teams, matches: matches));
  }
}
