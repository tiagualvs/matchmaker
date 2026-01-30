import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:result/result.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: tables, include: {'schema/schema.drift'})
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
        isolateDebugLog: true,
      ),
    );
  }

  AsyncResult<List<EventEntity>> getEventsWithLastMatch(String userId) async {
    final result = await (select(eventWithLastMatch)..where((tb) => tb.userId.equals(userId))).get();

    return Result.ok(result.map(EventEntity.withLastMatch).toList());
  }

  AsyncResult<List<EventEntity>> getEventsWithAllData(String userId) async {
    final result = await (select(eventWithAllData)..where((tb) => tb.userId.equals(userId))).get();

    return Result.ok(result.map(EventEntity.withAllData).toList());
  }

  AsyncResult<EventEntity> getEventWithAllData(int eventId) async {
    final result = await (select(eventWithAllData)..where((tb) => tb.id.equals(eventId))).getSingleOrNull();

    if (result == null) {
      return Result.error(Exception('Evento não encontrado!'));
    }

    return Result.ok(EventEntity.withAllData(result));
  }

  AsyncResult<MatchEntity> getMatchWithAllData(int id) async {
    final result = await (select(matchWithAllData)..where((tb) => tb.id.equals(id))).getSingleOrNull();

    if (result == null) {
      return Result.error(Exception('Partida não encontrada!'));
    }

    return Result.ok(MatchEntity.withAllData(result));
  }
}
