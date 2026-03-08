import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/common/shared/result.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_local_repository.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_local_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_local_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_local_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_local_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';
import 'package:matchmaker/src/data/services/database/app_database.dart';
import 'package:matchmaker/src/presentation/events/events.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mocktail/mocktail.dart';

class EventsMockRepository extends Mock implements EventsRepository {}

List<EventEntity> events([int len = 5]) => List.generate(
  5,
  (i) => EventEntity.empty().copyWith(
    name:
        '#$i Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
  ),
);

void injectorInit(Injector i) => i
  ..set<AppDatabase>(AppDatabase.testing())
  ..set<EventsRepository>(EventsLocalRepository(i.get()))
  ..set<MatchesRepository>(MatchesLocalRepository(i.get()))
  ..set<PlayersRepository>(PlayersLocalRepository(i.get()))
  ..set<ScoresRepository>(ScoresLocalRepository(i.get()))
  ..set<TeamsRepository>(TeamsLocalRepository(i.get()));

void main() {
  late final EventsRepository eventsRepository;

  setUpAll(() {
    eventsRepository = EventsMockRepository();

    Injector.instance.set<EventsRepository>(eventsRepository);
  });

  testWidgets('Must return a empty state when no events are found', (
    tester,
  ) async {
    when(() => eventsRepository.findMany()).thenAnswer(
      (_) async => const Result.value([]),
    );

    await tester.pumpWidget(const MaterialApp(home: Events()));

    await tester.pumpAndSettle();

    expect(find.byIcon(Symbols.event_rounded), findsOneWidget);

    expect(find.text('Nenhum evento encontrado'), findsOneWidget);

    verify(() => eventsRepository.findMany()).called(1);
  });

  testWidgets('Must return a list of events', (tester) async {
    final eventsList = events(3);

    when(() => eventsRepository.findMany()).thenAnswer(
      (_) async => Result.value(eventsList),
    );

    await tester.pumpWidget(const MaterialApp(home: Events()));

    await tester.pumpAndSettle();

    for (final event in eventsList) {
      expect(find.text(event.name), findsOneWidget);
    }

    verify(() => eventsRepository.findMany()).called(1);
  });
}
