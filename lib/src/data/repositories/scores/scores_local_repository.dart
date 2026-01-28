import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart';

import 'scores_repository.dart';

class ScoresLocalRepository implements ScoresRepository {
  final Database _db;

  const ScoresLocalRepository(this._db);

  @override
  AsyncResult<ScoreEntity> insertOne(InsertOneScoreParams params) async {
    final result = _db.select(
      'INSERT INTO tb_match_scores (match_id, team_id) VALUES (?, ?) RETURNING *',
      [params.matchId, params.teamId],
    );

    if (result.isEmpty) {
      return Result.error(Exception('Falha ao inserir novo score!'));
    }

    return Result.ok(ScoreEntity.fromSqlite(result[0]));
  }

  @override
  AsyncResult<ScoreEntity> updateOne(int id, bool reversed) async {
    final result = _db.select(
      'UPDATE tb_match_scores SET reversed = ? WHERE id = ? RETURNING *',
      [reversed, id],
    );

    if (result.isEmpty) {
      return Result.error(Exception('Falha ao atualizar score!'));
    }

    return Result.ok(ScoreEntity.fromSqlite(result[0]));
  }
}
