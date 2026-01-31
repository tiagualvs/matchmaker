import 'package:drift/drift.dart';
import 'package:matchmaker/src/common/shared/exceptions.dart';
import 'package:matchmaker/src/common/shared/result.dart' hide Value;
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';

import 'teams_repository.dart';

class TeamsLocalRepository implements TeamsRepository {
  final AppDatabase _db;

  const TeamsLocalRepository(this._db);

  @override
  AsyncResult<List<TeamEntity>> findMany(int eventId) async {
    try {
      final result = await (_db.select(_db.teamWithPlayers)..where((tb) => tb.eventId.equals(eventId))).get();

      return Result.value(result.map(TeamEntity.withPlayers).toList());
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao buscar times', e));
    }
  }

  @override
  AsyncResult<TeamEntity> findOne(int id) async {
    try {
      final result = await (_db.select(_db.teamWithPlayers)..where((tb) => tb.id.equals(id))).getSingleOrNull();

      if (result == null) {
        return const Result.error(AppException('Time não encontrado'));
      }

      return Result.value(TeamEntity.withPlayers(result));
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao buscar time', e));
    }
  }

  @override
  AsyncResult<TeamEntity> insertOne(InsertOneTeamParams params) async {
    try {
      return await _db.transaction(() async {
        final teamId = await _db
            .into(_db.team)
            .insert(
              TeamCompanion.insert(
                eventId: params.eventId,
                name: params.name,
              ),
            );

        for (final player in params.players) {
          await _db
              .into(_db.teamPlayer)
              .insert(
                TeamPlayerCompanion.insert(
                  teamId: teamId,
                  playerId: player.id,
                ),
              );
        }

        final result = await (_db.select(_db.teamWithPlayers)..where((tb) => tb.id.equals(teamId))).getSingle();

        return Result.value(TeamEntity.withPlayers(result));
      });
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao inserir time', e));
    }
  }

  @override
  AsyncResult<void> deleteOne(int id) async {
    try {
      await (_db.delete(_db.team)..where((tb) => tb.id.equals(id))).go();

      return const Result.value(null);
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao remover time', e));
    }
  }

  @override
  AsyncResult<void> insertPlayer(int teamId, int playerId) async {
    try {
      await _db
          .into(_db.teamPlayer)
          .insert(
            TeamPlayerCompanion.insert(
              teamId: teamId,
              playerId: playerId,
            ),
          );

      return const Result.value(null);
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao inserir jogador', e));
    }
  }

  @override
  AsyncResult<void> deletePlayer(int teamId, int playerId) async {
    try {
      await (_db.delete(
        _db.teamPlayer,
      )..where((tb) => tb.playerId.equals(playerId) & tb.teamId.equals(teamId))).go();

      return const Result.value(null);
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao remover jogador', e));
    }
  }

  @override
  AsyncResult<TeamEntity> updateOne(int id, UpdateOneTeamParams params) async {
    try {
      return await _db.transaction(() async {
        await (_db.update(_db.team)..where((tb) => tb.id.equals(id))).write(
          TeamCompanion(name: Value(params.name)),
        );

        final result = await (_db.select(_db.teamWithPlayers)..where((tb) => tb.id.equals(id))).getSingle();

        return Result.value(TeamEntity.withPlayers(result));
      });
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao atualizar time', e));
    }
  }
}
