import 'package:matchmaker/src/app_database.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:result/result.dart';
import 'package:sqlite3/sqlite3.dart' hide Session;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'scores_repository.dart';

class ScoresLocalRepository implements ScoresRepository {
  late final Database _db;
  late final Session? _session;

  ScoresLocalRepository(AppDatabase app) {
    _db = app.local;
    _session = app.remote.auth.currentSession;
  }

  @override
  AsyncResult<ScoreEntity> insertOne(InsertOneScoreParams params) async {
    final userId = _session?.user.id;

    if (userId == null) {
      return Result.error(Exception('Usuário não autenticado!'));
    }

    final result = _db.select(
      'INSERT INTO tb_match_scores (user_id, match_id, team_id) VALUES (?, ?, ?) RETURNING *',
      [userId, params.matchId, params.teamId],
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

  @override
  AsyncResult<ScoreEntity> deleteOne(int id) async {
    final result = _db.select('DELETE FROM tb_match_scores WHERE id = ? RETURNING *', [id]);

    return Result.ok(ScoreEntity.fromSqlite(result[0]));
  }
}
