import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart';

class ScoresRepository {
  const ScoresRepository(this._db);

  final Database _db;

  AsyncResult<ScoreEntity> insertOne(ScoreEntity score) async {
    _db.select(
      'INSERT INTO match_scores (id, match_id, team_id, reversed, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)',
      [
        score.id,
        score.matchId,
        score.teamId,
        score.reversed ? 1 : 0,
        score.createdAt.toUtc().toIso8601String(),
        score.updatedAt.toUtc().toIso8601String(),
      ],
    );

    return Result.ok(score);
  }
}
