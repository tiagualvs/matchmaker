import 'package:drift/drift.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';
import 'package:result/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'scores_repository.dart';

class ScoresLocalRepository implements ScoresRepository {
  late final AppDatabase _db;
  late final Session? _session;

  ScoresLocalRepository(AppDatabase app) {
    _session = Supabase.instance.client.auth.currentSession;
    _db = app;
  }

  @override
  AsyncResult<ScoreEntity> insertOne(InsertOneScoreParams params) async {
    try {
      final userId = _session?.user.id;

      if (userId == null) {
        return Result.error(Exception('Usuário não autenticado!'));
      }

      final score = await _db
          .into(_db.matchScore)
          .insertReturning(
            MatchScoreCompanion(
              userId: Value(userId),
              matchId: Value(params.matchId),
              teamId: Value(params.teamId),
            ),
          );

      return Result.ok(ScoreEntity.fromDrift(score));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  AsyncResult<ScoreEntity> updateOne(int id, bool reversed) async {
    try {
      final scores = await (_db.update(_db.matchScore)..where((tb) => tb.id.equals(id))).writeReturning(
        MatchScoreCompanion(
          reversed: Value(reversed),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

      if (scores.isEmpty) {
        return Result.error(Exception('Score não encontrado!'));
      }

      return Result.ok(ScoreEntity.fromDrift(scores.first));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  AsyncResult<ScoreEntity> deleteOne(int id) async {
    try {
      final scores = await (_db.delete(_db.matchScore)..where((tb) => tb.id.equals(id))).goAndReturn();

      if (scores.isEmpty) {
        return Result.error(Exception('Score não encontrado!'));
      }

      return Result.ok(ScoreEntity.fromDrift(scores.first));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
