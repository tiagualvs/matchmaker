import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matchmaker/src/app_widget.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/l10n/l10n_en.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';
import 'package:matchmaker/src/presentation/ui/widgets/current_match_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';

import 'extensions/common_finders_ext.dart';

final List<String> players = [
  'Tiago:h',
  'João:h',
  'Pedro:h',
  'Lucas:h',
  'Mateus:h',
  'Rafael:h',
  'Bruno:h',
  'Carlos:h',
  'Felipe:h',
  'André:h',
  'Ana:m',
  'Maria:m',
  'Juliana:m',
  'Camila:m',
  'Beatriz:m',
  'Larissa:m',
  'Patrícia:m',
  'Fernanda:m',
  'Daniela:m',
  'Renata:m',
];

String get playersAsRawList => players.indexed
    .map((e) => '${e.$1 + 1} - ${e.$2.split(':').first}')
    .join('\n');

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late final L10n l10n;
  late final String eventName;

  setUpAll(() async {
    // await initializeDateFormatting('en');
    l10n = L10nEn();

    Injector.instance.batch((i) async {
      final prefs = await SharedPreferencesService.test(
        encoders: {
          PlayerEntity.encoder(),
          EventEntity.encoder(),
        },
      );

      i.lazySet<SharedPreferencesService>(() => prefs);
    });
  });

  Future<void> enterOnEventsPageWithEmptyState(WidgetTester tester) async {
    final eventsPageAppBar = find.appBarWithTextTitle(l10n.appTitle);

    expect(eventsPageAppBar, findsOneWidget);

    await tester.pumpAndSettle();

    final eventsPageEmptyState = find.text(l10n.noEventsFound);

    expect(eventsPageEmptyState, findsOneWidget);

    final eventsPageFabMenu = find.fabWithAnimatedIconData(
      AnimatedIcons.menu_close,
    );

    expect(eventsPageFabMenu, findsOneWidget);

    await tester.tap(eventsPageFabMenu);

    await tester.pumpAndSettle();

    expect(find.text(l10n.singleMatch), findsOneWidget);

    expect(find.text(l10n.createNewEvent), findsOneWidget);

    await tester.tap(find.text(l10n.createNewEvent));

    await tester.pumpAndSettle();
  }

  Future<void> enterOnCreateEventPageToCreate(WidgetTester tester) async {
    final createEventPageAppBar = find.appBarWithTextTitle(eventName);

    expect(createEventPageAppBar, findsOneWidget);

    final createEventEmptyState = find.text(l10n.noTeamsRegistered);

    expect(createEventEmptyState, findsOneWidget);

    final createEventFabMenu = find.fabWithAnimatedIconData(
      AnimatedIcons.menu_close,
    );

    expect(createEventFabMenu, findsOneWidget);

    await tester.tap(createEventFabMenu);

    await tester.pumpAndSettle();

    expect(find.text(l10n.eventSettings), findsOneWidget);

    expect(find.text(l10n.importPlayersFromList), findsOneWidget);

    expect(find.text(l10n.addPlayer), findsOneWidget);

    await tester.tap(find.text(l10n.importPlayersFromList));

    await tester.pumpAndSettle();

    expect(find.text(l10n.importPlayers), findsOneWidget);

    await tester.tap(find.byType(TextFormField));

    await tester.enterText(find.byType(TextFormField), playersAsRawList);

    await tester.pumpAndSettle();

    final createEventImportButton = find.byKey(
      const ValueKey('CreateEventPage.importButton'),
    );

    expect(createEventImportButton, findsOneWidget);

    await tester.tap(createEventImportButton);

    await tester.pumpAndSettle();

    expect(find.text(l10n.playersCount(20)), findsOneWidget);

    final playersSingleChildScrollView = find.byType(SingleChildScrollView);

    expect(playersSingleChildScrollView, findsOneWidget);

    final orderedPlayers = List<String>.from(players)..sort();

    for (final player in orderedPlayers) {
      final name = player.split(':').first;

      final gender = player.split(':').last;

      final playerItem = find.text(name);

      await tester.scrollUntilVisible(
        playerItem,
        300,
        scrollable: find.descendant(
          of: playersSingleChildScrollView,
          matching: find.byType(Scrollable),
        ),
      );

      expect(playerItem, findsOneWidget);

      await tester.tap(playerItem);

      await tester.pumpAndSettle();

      expect(find.text(l10n.editPlayer), findsOneWidget);

      expect(find.text(l10n.male), findsOneWidget);

      expect(find.text(l10n.female), findsOneWidget);

      if (gender == 'm') {
        await tester.tap(find.text(l10n.female));
      } else if (gender == 'h') {
        await tester.tap(find.text(l10n.male));
      }

      await tester.pumpAndSettle();

      final playerInputSaveButton = find.byKey(
        const ValueKey('PlayerInputWidget.saveButton'),
      );

      expect(playerInputSaveButton, findsOneWidget);

      await tester.tap(playerInputSaveButton);

      await tester.pumpAndSettle();
    }

    // Should generate 5 teams

    expect(createEventFabMenu, findsOneWidget);

    await tester.tap(createEventFabMenu);

    await tester.pumpAndSettle();

    expect(find.text(l10n.eventSettings), findsOneWidget);

    expect(find.text(l10n.importPlayersFromList), findsOneWidget);

    expect(find.text(l10n.addPlayer), findsOneWidget);

    expect(find.text(l10n.generateTeams), findsOneWidget);

    await tester.tap(find.text(l10n.generateTeams));

    await tester.pumpAndSettle();

    final teamsSingleChildScrollView = find.byType(SingleChildScrollView);

    expect(find.text(l10n.teamsCount(5)), findsOneWidget);

    expect(teamsSingleChildScrollView, findsOneWidget);

    expect(find.byType(TeamCardWidget), findsExactly(5));

    // Should change event settings to HaltScoreToEliminate to TRUE and MaxWinsInARow to 3

    expect(createEventFabMenu, findsOneWidget);

    await tester.tap(createEventFabMenu);

    await tester.pumpAndSettle();

    expect(find.text(l10n.eventSettings), findsOneWidget);

    expect(find.text(l10n.undoTeams), findsOneWidget);

    expect(find.text(l10n.regenerateTeams), findsOneWidget);

    expect(find.text(l10n.saveEvent), findsOneWidget);

    await tester.tap(find.text(l10n.eventSettings));

    await tester.pumpAndSettle();

    expect(find.appBarWithTextTitle(l10n.settings), findsOneWidget);

    expect(find.text(l10n.eventSettingsTitle('other')), findsOneWidget);

    expect(
      find.ancestor(
        of: find.text(l10n.eventNameLabel),
        matching: find.byType(TextFormField),
      ),
      findsOneWidget,
    );

    expect(
      find.ancestor(
        of: find.text(l10n.pointsToWinLabel),
        matching: find.byType(TextFormField),
      ),
      findsOneWidget,
    );

    expect(
      find.ancestor(
        of: find.text(l10n.playersPerTeamLabel),
        matching: find.byType(TextFormField),
      ),
      findsOneWidget,
    );

    final maxWinsInARowInput = find.ancestor(
      of: find.text(l10n.maxWinsInARowLabel),
      matching: find.byType(TextFormField),
    );

    expect(maxWinsInARowInput, findsOneWidget);

    expect(
      find.switchListTile(l10n.eliminateAtHalf, false),
      findsOneWidget,
    );

    expect(
      find.switchListTile(l10n.balanceByGender, true),
      findsOneWidget,
    );

    expect(
      find.switchListTile(l10n.balanceByLevel, true),
      findsOneWidget,
    );

    await tester.tap(maxWinsInARowInput);

    await tester.enterText(maxWinsInARowInput, '3');

    await tester.pumpAndSettle();

    await tester.tap(find.switchListTile(l10n.eliminateAtHalf, false));

    await tester.pumpAndSettle();

    expect(
      find.switchListTile(l10n.eliminateAtHalf, true),
      findsOneWidget,
    );

    final saveButton = find.text(l10n.saveSettings);

    expect(saveButton, findsOneWidget);

    await tester.tap(saveButton);

    await tester.pumpAndSettle();

    expect(find.appBarWithTextTitle(eventName), findsOneWidget);

    expect(createEventFabMenu, findsOneWidget);

    await tester.tap(createEventFabMenu);

    await tester.pumpAndSettle();

    expect(find.text(l10n.eventSettings), findsOneWidget);

    expect(find.text(l10n.undoTeams), findsOneWidget);

    expect(find.text(l10n.regenerateTeams), findsOneWidget);

    expect(find.text(l10n.saveEvent), findsOneWidget);

    await tester.tap(find.text(l10n.saveEvent));

    await tester.pumpAndSettle();
  }

  Future<void> enterOnEventsPageWithLoadedState(WidgetTester tester) async {
    final eventsPageAppBar = find.appBarWithTextTitle(l10n.appTitle);

    expect(eventsPageAppBar, findsOneWidget);

    final eventsLoadedPage = find.byType(ListView);

    expect(eventsLoadedPage, findsOneWidget);

    final eventTile = find.byWidgetPredicate((w) {
      if (w is! ListTile) return false;

      final title = w.title;

      if (title is! Text) return false;

      return title.data == eventName;
    });

    expect(eventTile, findsOneWidget);

    await tester.tap(eventTile);

    await tester.pumpAndSettle();
  }

  Future<void> enterOnEventPageWithLoadedState(WidgetTester tester) async {
    final eventPageAppBar = find.appBarWithTextTitle(eventName);

    expect(eventPageAppBar, findsOneWidget);

    final currentMatchCard = find.byType(CurrentMatchWidget);

    expect(currentMatchCard, findsOneWidget);

    await tester.tap(currentMatchCard);

    await tester.pumpAndSettle();
  }

  Future<void> enterOnMatchPageWithLoadedState(WidgetTester tester) async {
    Finder teamButtonScore(Color color, int value) {
      return find.ancestor(
        of: find.ancestor(
          of: find.ancestor(
            of: find.text(value.toString()),
            matching: find.byType(FittedBox),
          ),
          matching: find.byWidgetPredicate((w) {
            if (w is! Material) return false;

            return w.color == color;
          }),
        ),
        matching: find.byType(GestureDetector),
      );
    }

    Finder firstTeamButtonScore(int value) {
      return teamButtonScore(Colors.blue, value);
    }

    Finder secondTeamButtonScore(int value) {
      return teamButtonScore(Colors.red, value);
    }

    expect(firstTeamButtonScore(0), findsOneWidget);

    expect(secondTeamButtonScore(0), findsOneWidget);

    for (var i = 0; i < 6; i++) {
      await tester.tap(firstTeamButtonScore(i));

      await tester.pump();

      expect(firstTeamButtonScore(i + 1), findsOneWidget);

      expect(secondTeamButtonScore(0), findsOneWidget);
    }
  }

  testWidgets(
    'Complete flow: create an event, add 12 players, create teams and start the match!',
    (tester) async {
      await tester.pumpWidget(const AppWidget.test());

      eventName = l10n.defaultEventName(DateTime.now());

      await tester.pumpAndSettle();

      await enterOnEventsPageWithEmptyState(tester);

      await enterOnCreateEventPageToCreate(tester);

      await enterOnEventsPageWithLoadedState(tester);

      await enterOnEventPageWithLoadedState(tester);

      await enterOnMatchPageWithLoadedState(tester);
    },
  );
}
