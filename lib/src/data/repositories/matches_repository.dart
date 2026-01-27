import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart';

class MatchesRepository {
  const MatchesRepository(this._db);

  final Database _db;

  AsyncResult<MatchEntity> findOne(String id) async {
    final result = _db.select(
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
      WHERE em.id = ?;''',
      [id],
    );

    if (result.isEmpty) {
      return Result.error(Exception('Match not found'));
    }

    final match = MatchEntity.fromSqlite(result.first);

    final scoresResult = _db.select(
      'SELECT * FROM match_scores WHERE match_id = ?;',
      [match.id],
    );

    final scores = scoresResult.map(ScoreEntity.fromSqlite).toList();

    return Result.ok(match.copyWith(scores: scores));
  }

  AsyncResult<void> updateOne(MatchEntity match) async {
    _db.execute(
      'UPDATE event_matches SET name = ?, max_score = ?, ended = ?, updated_at = ?, ended_at = ? WHERE id = ?',
      [
        match.name,
        match.maxScore,
        match.ended ? 1 : 0,
        match.updatedAt.toUtc().toIso8601String(),
        match.endedAt?.toUtc().toIso8601String(),
        match.id,
      ],
    );

    return const Result.ok(null);
  }
}
