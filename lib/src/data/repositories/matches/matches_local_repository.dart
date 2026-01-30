import 'package:drift/drift.dart';
import 'package:matchmaker/src/common/shared/exceptions.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';
import 'package:result/result.dart';

import 'matches_repository.dart';

class MatchesLocalRepository implements MatchesRepository {
  final AppDatabase _db;

  const MatchesLocalRepository(this._db);

  @override
  AsyncResult<MatchEntity> insertOne(InsertOneMatchParams params) async {
    try {
      return await _db.transaction(() async {
        final matchId = await _db
            .into(_db.eventMatch)
            .insert(
              EventMatchCompanion.insert(
                eventId: params.eventId,
                name: params.name,
                firstTeamId: params.firstTeamId,
                secondTeamId: params.secondTeamId,
                maxScore: params.maxScore,
                halfScoreToEliminate: params.halfScoreToEliminate,
              ),
            );

        await (_db.update(_db.event)..where((tb) => tb.id.equals(params.eventId))).write(
          EventCompanion(
            queue: Value(params.queue.join(',')),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );

        final result = await (_db.select(_db.matchWithAllData)..where((tb) => tb.id.equals(matchId))).getSingleOrNull();

        if (result == null) {
          return const Result.error(AppException('Partida não encontrada!'));
        }

        return Result.ok(MatchEntity.withAllData(result));
      });
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao inserir partida!', e));
    }
  }

  @override
  AsyncResult<MatchEntity> findOne(int id) async {
    try {
      return await _db.getMatchWithAllData(id);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  AsyncResult<MatchEntity> updateOne(int id, UpdateOneMatchParams params) async {
    try {
      return await _db.transaction(() async {
        await (_db.update(_db.eventMatch)..where((tb) => tb.id.equals(id))).write(
          EventMatchCompanion(
            name: params.name != null ? Value(params.name!) : const Value.absent(),
            maxScore: params.maxScore != null ? Value(params.maxScore!) : const Value.absent(),
            halfScoreToEliminate: params.halfScoreToEliminate != null
                ? Value(params.halfScoreToEliminate!)
                : const Value.absent(),
            ended: params.ended != null ? Value(params.ended!) : const Value.absent(),
            endedAt: params.ended != null && params.ended == true
                ? Value(DateTime.now().toUtc())
                : const Value.absent(),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );

        final result = await (_db.select(_db.matchWithAllData)..where((tb) => tb.id.equals(id))).getSingleOrNull();

        if (result == null) {
          return const Result.error(AppException('Partida não encontrada!'));
        }

        return Result.ok(MatchEntity.withAllData(result));
      });
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao buscar partida por id!', e));
    }
  }

  @override
  AsyncResult<void> updateManyByEventId(int eventId, UpdateOneMatchParams params) async {
    try {
      return await _db.transaction(() async {
        await (_db.update(_db.eventMatch)..where((tb) => tb.eventId.equals(eventId))).write(
          EventMatchCompanion(
            name: params.name != null ? Value(params.name!) : const Value.absent(),
            maxScore: params.maxScore != null ? Value(params.maxScore!) : const Value.absent(),
            halfScoreToEliminate: params.halfScoreToEliminate != null
                ? Value(params.halfScoreToEliminate!)
                : const Value.absent(),
            ended: params.ended != null ? Value(params.ended!) : const Value.absent(),
            endedAt: params.ended != null && params.ended == true
                ? Value(DateTime.now().toUtc())
                : const Value.absent(),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );

        return const Result.ok(null);
      });
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao buscar partida por id!', e));
    }
  }

  @override
  AsyncResult<void> deleteOne(int id) async {
    try {
      await (_db.delete(_db.eventMatch)..where((tb) => tb.id.equals(id))).go();
      return const Result.ok(null);
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao deletar partida!', e));
    }
  }

  @override
  AsyncResult<void> deleteManyByEventId(int eventId) async {
    try {
      await (_db.delete(_db.eventMatch)..where((tb) => tb.eventId.equals(eventId))).go();
      return const Result.ok(null);
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao dele tar partidas por evento!', e));
    }
  }
}
