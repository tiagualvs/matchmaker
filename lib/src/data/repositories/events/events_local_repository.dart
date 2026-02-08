import 'package:drift/drift.dart';
import 'package:matchmaker/src/common/shared/exceptions.dart';
import 'package:matchmaker/src/common/shared/result.dart' hide Value;
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/services/database/app_database.dart';

import 'events_repository.dart';

class EventsLocalRepository implements EventsRepository {
  final AppDatabase _db;

  const EventsLocalRepository(this._db);

  @override
  AsyncResult<List<EventEntity>> findMany() async {
    try {
      return await _db.getEventsWithLastMatch();
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao buscar eventos!', e));
    }
  }

  @override
  AsyncResult<EventEntity> findOne(int id) async {
    try {
      return await _db.getEventWithAllData(id);
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao buscar evento por id!', e));
    }
  }

  @override
  AsyncResult<EventEntity> insertOne(InsertOneEventParams params) async {
    try {
      return await _db.transaction(
        () async {
          final event = await _db
              .into(_db.event)
              .insertReturning(
                EventCompanion.insert(
                  name: params.name,
                  maxScore: Value(params.maxScore),
                  halfScoreToEliminate: Value(params.halfScoreToEliminate),
                  maxPlayerPerTeam: Value(params.maxPlayerPerTeam),
                  balancedByGender: Value(params.balancedByGender),
                  balancedByLevel: Value(params.balancedByLevel),
                  maxWinsInARow: Value(params.maxWinsInARow),
                ),
              );

          final teamIds = <int>[];

          for (final t in params.teams) {
            final teamId = await _db
                .into(_db.team)
                .insert(
                  TeamCompanion.insert(
                    eventId: event.id,
                    name: t.name,
                  ),
                );

            for (final p in t.players) {
              if (p.isJoker) continue;

              final player = await _db
                  .into(_db.player)
                  .insertReturning(
                    PlayerCompanion.insert(
                      name: p.name,
                      gender: Value(p.gender.value),
                      level: Value(p.level.value),
                    ),
                    onConflict: DoUpdate(
                      (old) => PlayerCompanion.custom(id: old.id),
                      target: [_db.player.name, _db.player.gender],
                    ),
                  );

              await _db
                  .into(_db.teamPlayer)
                  .insert(
                    TeamPlayerCompanion.insert(
                      teamId: teamId,
                      playerId: player.id,
                    ),
                  );
            }

            teamIds.add(teamId);
          }

          final starterTeams = teamIds.take(2);

          await _db
              .into(_db.match)
              .insert(
                MatchCompanion.insert(
                  eventId: event.id,
                  name: '#1',
                  firstTeamId: starterTeams.first,
                  secondTeamId: starterTeams.last,
                  maxScore: event.maxScore,
                  halfScoreToEliminate: event.halfScoreToEliminate,
                ),
              );

          final queue = teamIds.skip(2).join(',');

          final updateQuery = _db.update(_db.event)..where((tb) => tb.id.equals(event.id));

          await updateQuery.write(EventCompanion(queue: Value(queue)));

          final result = await (_db.select(
            _db.eventWithAllData,
          )..where((tb) => tb.id.equals(event.id))).getSingleOrNull();

          if (result == null) {
            return const Result.error(AppException('Evento não encontrado!'));
          }

          return Result.value(EventEntity.withAllData(result));
        },
      );
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao inserir evento!', e));
    }
  }

  @override
  AsyncResult<EventEntity> updateOne(int id, UpdateOneEventParams params) async {
    try {
      return await _db.transaction(() async {
        final updateQuery = _db.update(_db.event)..where((tb) => tb.id.equals(id));

        await updateQuery.write(
          EventCompanion(
            name: params.name != null ? Value(params.name!) : const Value.absent(),
            maxScore: params.maxScore != null ? Value(params.maxScore!) : const Value.absent(),
            halfScoreToEliminate: params.halfScoreToEliminate != null
                ? Value(params.halfScoreToEliminate!)
                : const Value.absent(),
            maxPlayerPerTeam: params.maxPlayerPerTeam != null ? Value(params.maxPlayerPerTeam!) : const Value.absent(),
            balancedByGender: params.balancedByGender != null ? Value(params.balancedByGender!) : const Value.absent(),
            balancedByLevel: params.balancedByLevel != null ? Value(params.balancedByLevel!) : const Value.absent(),
            maxWinsInARow: params.maxWinsInARow != null ? Value(params.maxWinsInARow!) : const Value.absent(),
            queue: params.queue != null ? Value(params.queue!.join(',')) : const Value.absent(),
            ended: params.ended != null ? Value(params.ended!) : const Value.absent(),
            endedAt: params.ended != null && params.ended == true
                ? Value(DateTime.now().toUtc())
                : const Value.absent(),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );

        final result = await (_db.select(
          _db.eventWithAllData,
        )..where((tb) => tb.id.equals(id))).getSingleOrNull();

        if (result == null) {
          return const Result.error(AppException('Evento não encontrado!'));
        }

        return Result.value(EventEntity.withAllData(result));
      });
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao atualizar evento!', e));
    }
  }

  @override
  AsyncResult<void> deleteOne(int id) async {
    try {
      await (_db.delete(_db.event)..where((tb) => tb.id.equals(id))).go();

      return const Result.value(null);
    } on DriftWrappedException catch (e) {
      return Result.error(AppException(e.message, e));
    } on Exception catch (e) {
      return Result.error(AppException('Falha ao deletar evento!', e));
    }
  }
}
