import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/app_widget.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
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

final eventName =
    'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    Injector.test();
  });

  Future<void> enterOnEventsPageWithEmptyState(WidgetTester tester) async {
    final eventsPageAppBar = find.appBarWithTextTitle('Matchmaker');

    expect(eventsPageAppBar, findsOneWidget);

    await tester.pumpAndSettle();

    final eventsPageEmptyState = find.text('Nenhum evento encontrado');

    expect(eventsPageEmptyState, findsOneWidget);

    final eventsPageFabMenu = find.fabWithAnimatedIconData(
      AnimatedIcons.menu_close,
    );

    expect(eventsPageFabMenu, findsOneWidget);

    await tester.tap(eventsPageFabMenu);

    await tester.pumpAndSettle();

    expect(find.text('Partida avulsa'), findsOneWidget);

    expect(find.text('Criar novo evento'), findsOneWidget);

    await tester.tap(find.text('Criar novo evento'));

    await tester.pumpAndSettle();
  }

  Future<void> enterOnCreateEventPageToCreate(WidgetTester tester) async {
    final createEventPageAppBar = find.appBarWithTextTitle(eventName);

    expect(createEventPageAppBar, findsOneWidget);

    final createEventEmptyState = find.text('Nenhum time cadastrado no evento');

    expect(createEventEmptyState, findsOneWidget);

    final createEventFabMenu = find.fabWithAnimatedIconData(
      AnimatedIcons.menu_close,
    );

    expect(createEventFabMenu, findsOneWidget);

    await tester.tap(createEventFabMenu);

    await tester.pumpAndSettle();

    expect(find.text('Configurações do evento'), findsOneWidget);

    expect(find.text('Importar jogadores de lista'), findsOneWidget);

    expect(find.text('Adicionar jogador'), findsOneWidget);

    await tester.tap(find.text('Importar jogadores de lista'));

    await tester.pumpAndSettle();

    expect(find.text('Importar Jogadores'), findsOneWidget);

    await tester.tap(find.byType(TextFormField));

    await tester.enterText(find.byType(TextFormField), playersAsRawList);

    await tester.pumpAndSettle();

    final createEventImportButton = find.byKey(
      const ValueKey('CreateEventPage.importButton'),
    );

    expect(createEventImportButton, findsOneWidget);

    await tester.tap(createEventImportButton);

    await tester.pumpAndSettle();

    expect(find.text('Jogadores (20)'), findsOneWidget);

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

      expect(find.text('Editar Jogador'), findsOneWidget);

      expect(find.text('Masculino'), findsOneWidget);

      expect(find.text('Feminino'), findsOneWidget);

      if (gender == 'm') {
        await tester.tap(find.text('Feminino'));
      } else if (gender == 'h') {
        await tester.tap(find.text('Masculino'));
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

    expect(find.text('Configurações do evento'), findsOneWidget);

    expect(find.text('Importar jogadores de lista'), findsOneWidget);

    expect(find.text('Adicionar jogador'), findsOneWidget);

    expect(find.text('Gerar times'), findsOneWidget);

    await tester.tap(find.text('Gerar times'));

    await tester.pumpAndSettle();

    final teamsSingleChildScrollView = find.byType(SingleChildScrollView);

    expect(find.text('Times (5)'), findsOneWidget);

    expect(teamsSingleChildScrollView, findsOneWidget);

    expect(find.byType(TeamCardWidget), findsExactly(5));

    // Should change event settings to HaltScoreToEliminate to TRUE and MaxWinsInARow to 3

    expect(createEventFabMenu, findsOneWidget);

    await tester.tap(createEventFabMenu);

    await tester.pumpAndSettle();

    expect(find.text('Configurações do evento'), findsOneWidget);

    expect(find.text('Desfazer times'), findsOneWidget);

    expect(find.text('Regerar times'), findsOneWidget);

    expect(find.text('Salvar evento'), findsOneWidget);

    await tester.tap(find.text('Configurações do evento'));

    await tester.pumpAndSettle();

    expect(find.appBarWithTextTitle('Configurações'), findsOneWidget);

    expect(
      find.ancestor(
        of: find.text('Nome do Evento'),
        matching: find.byType(TextFormField),
      ),
      findsOneWidget,
    );

    expect(
      find.ancestor(
        of: find.text('Quantidade de pontos para vencer'),
        matching: find.byType(TextFormField),
      ),
      findsOneWidget,
    );

    expect(
      find.ancestor(
        of: find.text('Quantidade de jogadores por time'),
        matching: find.byType(TextFormField),
      ),
      findsOneWidget,
    );

    final maxWinsInARowInput = find.ancestor(
      of: find.text('Máximo de vitórias em sequência'),
      matching: find.byType(TextFormField),
    );

    expect(maxWinsInARowInput, findsOneWidget);

    expect(
      find.switchListTile('Eliminar na metade?', false),
      findsOneWidget,
    );

    expect(
      find.switchListTile('Balancear por gênero?', true),
      findsOneWidget,
    );

    expect(
      find.switchListTile('Balancear por nível?', true),
      findsOneWidget,
    );

    await tester.tap(maxWinsInARowInput);

    await tester.enterText(maxWinsInARowInput, '3');

    await tester.pumpAndSettle();

    await tester.tap(find.switchListTile('Eliminar na metade?', false));

    await tester.pumpAndSettle();

    expect(
      find.switchListTile('Eliminar na metade?', true),
      findsOneWidget,
    );

    final saveButton = find.text('Salvar configurações');

    expect(saveButton, findsOneWidget);

    await tester.tap(saveButton);

    await tester.pumpAndSettle();

    expect(find.appBarWithTextTitle(eventName), findsOneWidget);

    expect(createEventFabMenu, findsOneWidget);

    await tester.tap(createEventFabMenu);

    await tester.pumpAndSettle();

    expect(find.text('Configurações do evento'), findsOneWidget);

    expect(find.text('Desfazer times'), findsOneWidget);

    expect(find.text('Regerar times'), findsOneWidget);

    expect(find.text('Salvar evento'), findsOneWidget);

    await tester.tap(find.text('Salvar evento'));

    await tester.pumpAndSettle();
  }

  Future<void> enterOnEventsPageWithLoadedState(WidgetTester tester) async {
    final eventsPageAppBar = find.appBarWithTextTitle('Matchmaker');

    expect(eventsPageAppBar, findsOneWidget);

    final eventsLoadedPage = find.byType(ListView);

    expect(eventsLoadedPage, findsOneWidget);

    final eventTile = find.byWidgetPredicate((w) {
      if (w is! ListTile) return false;

      final title = w.title;

      if (title is! Text) return false;

      return title.data ==
          'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}';
    });

    expect(eventTile, findsOneWidget);

    await tester.tap(eventTile);

    await tester.pumpAndSettle();
  }

  Future<void> enterOnEventPageWithLoadedState(WidgetTester tester) async {
    final eventPageAppBar = find.appBarWithTextTitle(
      'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
    );

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
      await tester.pumpWidget(const AppWidget());

      await tester.pumpAndSettle();

      await enterOnEventsPageWithEmptyState(tester);

      await enterOnCreateEventPageToCreate(tester);

      await enterOnEventsPageWithLoadedState(tester);

      await enterOnEventPageWithLoadedState(tester);

      await enterOnMatchPageWithLoadedState(tester);
    },
  );
}
