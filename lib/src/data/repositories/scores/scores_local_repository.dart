import 'package:drift/drift.dart';
import 'package:matchmaker/src/common/shared/exceptions.dart';
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
        return const Result.error(AppException('Usuário não autenticado!'));
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
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao inserir score!', e));
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
        return const Result.error(AppException('Score não encontrado!'));
      }

      return Result.ok(ScoreEntity.fromDrift(scores.first));
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao atualizar score!', e));
    }
  }

  @override
  AsyncResult<ScoreEntity> deleteOne(int id) async {
    try {
      final scores = await (_db.delete(_db.matchScore)..where((tb) => tb.id.equals(id))).goAndReturn();

      if (scores.isEmpty) {
        return const Result.error(AppException('Score não encontrado!'));
      }

      return Result.ok(ScoreEntity.fromDrift(scores.first));
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao deletar score!', e));
    }
  }
}
