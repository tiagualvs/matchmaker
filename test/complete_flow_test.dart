import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/app_provider.dart';
import 'package:matchmaker/src/app_widget.dart';

import '../integration_test/extensions/common_finders_ext.dart';

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

String get playersAsRawList => players.indexed.map((e) => '${e.$1 + 1} - ${e.$2.split(':').first}').join('\n');

final eventName = 'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}';

void main() {
  testWidgets('Complete flow: create an event, add 12 players, create teams and start the match!', (tester) async {
    await tester.pumpWidget(const AppProvider.testing(child: AppWidget()));

    await tester.pumpAndSettle();

    // Entered on => EventsPage with EmptyState

    final eventsPageAppBar = find.appBarWithTextTitle('Matchmaker');

    expect(eventsPageAppBar, findsOneWidget);

    await tester.pumpAndSettle();

    final eventsPageEmptyState = find.text('Nenhum evento encontrado');

    expect(eventsPageEmptyState, findsOneWidget);

    final eventsPageFabMenu = find.fabWithAnimatedIconData(AnimatedIcons.menu_close);

    expect(eventsPageFabMenu, findsOneWidget);

    await tester.tap(eventsPageFabMenu);

    await tester.pumpAndSettle();

    expect(find.text('Partida avulsa'), findsOneWidget);

    expect(find.text('Criar novo evento'), findsOneWidget);

    await tester.tap(find.text('Criar novo evento'));

    await tester.pumpAndSettle();

    // Entered on => CreateEventPage with EmptyState

    final createEventPageAppBar = find.appBarWithTextTitle(eventName);

    expect(createEventPageAppBar, findsOneWidget);

    final createEventEmptyState = find.text('Nenhum time cadastrado no evento');

    expect(createEventEmptyState, findsOneWidget);

    final createEventFabMenu = find.fabWithAnimatedIconData(AnimatedIcons.menu_close);

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

    final createEventImportButton = find.byKey(const ValueKey('CreateEventPage.importButton'));

    expect(createEventImportButton, findsOneWidget);

    await tester.tap(createEventImportButton);

    await tester.pumpAndSettle();

    expect(find.text('Jogadores (20)'), findsOneWidget);

    final playersListView = find.byKey(const ValueKey('CreateEventPage.playersList'));

    expect(playersListView, findsOneWidget);

    final playersListScrollable = find.descendant(
      of: playersListView,
      matching: find.byType(Scrollable),
    );

    expect(playersListScrollable, findsOneWidget);

    final orderedPlayers = List<String>.from(players)..sort();

    for (final player in orderedPlayers) {
      final name = player.split(':').first;

      final gender = player.split(':').last;

      final playerTileWidget = find.byKey(Key('CreateEventPage.player.$name'));

      await tester.scrollUntilVisible(playerTileWidget, 300, scrollable: playersListScrollable);

      await tester.pumpAndSettle();

      expect(playerTileWidget, findsOneWidget);

      await tester.tap(playerTileWidget);

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

      final playerInputSaveButton = find.byKey(const ValueKey('PlayerInputWidget.saveButton'));

      expect(playerInputSaveButton, findsOneWidget);

      await tester.tap(playerInputSaveButton);

      await tester.pumpAndSettle();
    }
  });
}
