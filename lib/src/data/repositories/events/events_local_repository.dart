import 'package:drift/drift.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';
import 'package:result/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'events_repository.dart';

class EventsLocalRepository implements EventsRepository {
  late final Session? _session;
  late final AppDatabase _db;

  EventsLocalRepository(AppDatabase app) {
    _session = Supabase.instance.client.auth.currentSession;
    _db = app;
  }

  @override
  AsyncResult<List<EventEntity>> findMany() async {
    try {
      final userId = _session?.user.id;

      if (userId == null) {
        return Result.error(Exception('Você precisa estar autenticado para realizar esta ação!'));
      }

      return await _db.getEventsWithLastMatch(userId);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  AsyncResult<EventEntity> findOne(int id) async {
    try {
      return await _db.getEventWithAllData(id);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  AsyncResult<EventEntity> insertOne(InsertOneEventParams params) async {
    try {
      final userId = _session?.user.id;

      if (userId == null) {
        return Result.error(Exception('Você precisa estar autenticado para realizar esta ação!'));
      }

      return await _db.transaction(
        () async {
          final event = await _db
              .into(_db.event)
              .insertReturning(
                EventCompanion.insert(
                  userId: userId,
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
                .into(_db.eventTeam)
                .insert(
                  EventTeamCompanion.insert(
                    userId: userId,
                    eventId: event.id,
                    name: t.name,
                  ),
                );

            for (final p in t.players) {
              final player = await _db
                  .into(_db.player)
                  .insertReturning(
                    PlayerCompanion.insert(
                      userId: userId,
                      name: p.name,
                      gender: p.gender.value,
                      level: p.level.value,
                    ),
                    onConflict: DoUpdate(
                      (old) => PlayerCompanion.custom(id: old.id),
                      target: [_db.player.name],
                    ),
                  );

              await _db
                  .into(_db.eventTeamPlayer)
                  .insert(
                    EventTeamPlayerCompanion.insert(
                      userId: userId,
                      teamId: teamId,
                      playerId: player.id,
                    ),
                  );
            }

            teamIds.add(teamId);
          }

          final starterTeams = teamIds.take(2);

          await _db
              .into(_db.eventMatch)
              .insert(
                EventMatchCompanion.insert(
                  userId: userId,
                  eventId: event.id,
                  name: 'Partida #1',
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
            return Result.error(Exception('Evento não encontrado!'));
          }

          return Result.ok(EventEntity.withAllData(result));
        },
      );
    } on Exception catch (e) {
      return Result.error(e);
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
            // queue: ,
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
          return Result.error(Exception('Evento não encontrado!'));
        }

        return Result.ok(EventEntity.withAllData(result));
      });
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  AsyncResult<void> deleteOne(int id) async {
    try {
      await (_db.delete(_db.event)..where((tb) => tb.id.equals(id))).go();

      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
