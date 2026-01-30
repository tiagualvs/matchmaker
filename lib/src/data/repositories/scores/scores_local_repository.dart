import 'package:drift/drift.dart';
import 'package:matchmaker/src/common/shared/exceptions.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';
import 'package:result/result.dart';

import 'scores_repository.dart';

class ScoresLocalRepository implements ScoresRepository {
  final AppDatabase _db;

  const ScoresLocalRepository(this._db);

  @override
  AsyncResult<ScoreEntity> insertOne(InsertOneScoreParams params) async {
    try {
      final score = await _db
          .into(_db.matchScore)
          .insertReturning(
            MatchScoreCompanion(
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
