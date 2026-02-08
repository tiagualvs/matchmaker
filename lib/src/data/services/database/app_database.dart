import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:matchmaker/src/common/shared/result.dart' hide Value;
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: tables, include: {'schema/schema.drift'})
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  factory AppDatabase.testing() {
    return AppDatabase(_openConnection(true));
  }

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection([bool testing = false]) {
    if (testing) {
      return NativeDatabase.memory();
    }

    return driftDatabase(
      name: 'database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
        isolateDebugLog: kDebugMode,
      ),
    );
  }

  AsyncResult<List<EventEntity>> getEventsWithLastMatch() async {
    final result = await select(eventWithLastMatch).get();

    return Result.value(result.map(EventEntity.withLastMatch).toList());
  }

  AsyncResult<List<EventEntity>> getEventsWithAllData() async {
    final result = await select(eventWithAllData).get();

    return Result.value(result.map(EventEntity.withAllData).toList());
  }

  AsyncResult<EventEntity> getEventWithAllData(int eventId) async {
    final result = await (select(eventWithAllData)..where((tb) => tb.id.equals(eventId))).getSingleOrNull();

    if (result == null) {
      return Result.error(Exception('Evento não encontrado!'));
    }

    return Result.value(EventEntity.withAllData(result));
  }

  AsyncResult<MatchEntity> getMatchWithAllData(int matchId) async {
    final result = await (select(matchWithAllData)..where((tb) => tb.id.equals(matchId))).getSingleOrNull();

    if (result == null) {
      return Result.error(Exception('Partida não encontrada!'));
    }

    return Result.value(MatchEntity.withAllData(result));
  }
}
