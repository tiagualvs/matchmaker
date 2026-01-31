import 'package:drift/drift.dart';
import 'package:matchmaker/src/common/shared/exceptions.dart';
import 'package:matchmaker/src/common/shared/result.dart' hide Value;
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';

import 'players_repository.dart';

class PlayersLocalRepository implements PlayersRepository {
  final AppDatabase _db;

  const PlayersLocalRepository(this._db);

  @override
  AsyncResult<PlayerEntity> insertOne(InsertOnePlayerParams params) async {
    try {
      final player = await _db
          .into(_db.player)
          .insertReturning(
            PlayerCompanion.insert(
              name: params.name,
              gender: Value(params.gender),
              level: Value(params.level),
            ),
            onConflict: DoUpdate(
              (old) => PlayerCompanion.custom(id: old.id),
              target: [_db.player.name, _db.player.gender],
            ),
          );

      return Result.value(PlayerEntity.fromDrift(player));
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao inserir jogador!', e));
    }
  }

  @override
  AsyncResult<PlayerEntity> findOneById(int id) async {
    try {
      final player = await (_db.player.select()..where((t) => t.id.equals(id))).getSingleOrNull();

      if (player == null) {
        return const Result.error(AppException('Jogador não encontrado!'));
      }

      return Result.value(PlayerEntity.fromDrift(player));
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao buscar jogador por id!', e));
    }
  }

  @override
  AsyncResult<PlayerEntity> findOneByName(String name) async {
    try {
      final player = await (_db.player.select()..where((t) => t.name.equals(name))).getSingleOrNull();

      if (player == null) {
        return const Result.error(AppException('Jogador não encontrado!'));
      }

      return Result.value(PlayerEntity.fromDrift(player));
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao buscar jogador por nome!', e));
    }
  }

  @override
  AsyncResult<PlayerEntity> updateOne(int id, UpdateOnePlayerParams params) async {
    try {
      if (!params.hasChanges) {
        return const Result.error(AppException('Nenhuma alteração detectada!'));
      }

      final players = await (_db.update(_db.player)..where((t) => t.id.equals(id))).writeReturning(
        PlayerCompanion(
          name: params.name != null ? Value(params.name!) : const Value.absent(),
          gender: params.gender != null ? Value(params.gender!) : const Value.absent(),
          level: params.level != null ? Value(params.level!) : const Value.absent(),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

      if (players.isEmpty) {
        return const Result.error(AppException('Falha ao atualizar jogador!'));
      }

      return Result.value(PlayerEntity.fromDrift(players.first));
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao atualizar jogador!', e));
    }
  }
}
