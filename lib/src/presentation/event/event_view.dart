import 'dart:core' hide Match;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/dialogs.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/others/text_span_builder.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/presentation/event_settings/event_settings.dart';
import 'package:matchmaker/src/presentation/match/match.dart';
import 'package:matchmaker/src/presentation/match_history/match_history.dart';
import 'package:matchmaker/src/presentation/ui/widgets/current_match_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'event_view_model.dart';

class EventView extends EventViewModel {
  Future<void> onNeedJokers(String message) async {
    return await Dialogs.display(
      context,
      title: const Text('Jogador ausente!'),
      content: Text.rich(
        TextSpanBuilder.build(
          message,
          normalStyle: context.textTheme.bodyLarge,
          boldStyle: context.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Future<void> onMaxWinsInARow(String message) async {
    return await Dialogs.display(
      context,
      title: Text(
        'Máximo de vitórias atingida!',
        style: context.textTheme.headlineMedium?.copyWith(fontWeight: .bold),
      ),
      content: Text.rich(
        TextSpanBuilder.build(
          message,
          normalStyle: context.textTheme.bodyLarge,
          boldStyle: context.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButtonMenu(
      menus: switch (sharing) {
        true => [],
        false => [
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.settings_rounded),
            label: const Text('Configurações'),
            onPressed: () async {
              await EventSettings.push(context, event);

              return await reloadEvent(
                onError: SnackBars.error,
                onMaxWinsInARow: onMaxWinsInARow,
                onNeedJokers: onNeedJokers,
              );
            },
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.list_rounded),
            label: const Text('Histórico de partidas'),
            onPressed: () async {
              await MatchHistory.push(context, event);

              return await reloadEvent(
                onError: SnackBars.error,
                onMaxWinsInARow: onMaxWinsInARow,
                onNeedJokers: onNeedJokers,
              );
            },
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.groups_rounded),
            label: const Text('Ajustar times'),
            onPressed: () async {
              await context.pushNamed(
                'teams',
                pathParameters: {
                  'eventId': event.id.toString(),
                },
              );

              return await reloadEvent(
                onError: SnackBars.error,
                onMaxWinsInARow: onMaxWinsInARow,
                onNeedJokers: onNeedJokers,
              );
            },
          ),
          if (!event.ended) ...[
            FloatingActionButtonMenuItem(
              icon: const Icon(Icons.flag_rounded),
              label: const Text('Finalizar evento'),
              onPressed: () async {
                final hasEndedMatches = event.endedMatches.isNotEmpty;

                final confirm = await Dialogs.display(
                  context,
                  title: const Text('Finalizar evento?'),
                  content: Text(
                    'Tem certeza que deseja finalizar este evento?\n\nTodas as partidas em andamento serão canceladas.${!hasEndedMatches ? '\n\nEsse evento não possui partidas finalizadas, então ele será excluído por completo!' : ''}\n\nEssa ação não poderá ser desfeita!\n\nDeseja prosseguir?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(false),
                      child: const Text('Não'),
                    ),
                    TextButton(
                      onPressed: () => context.pop(true),
                      child: const Text('Sim'),
                    ),
                  ],
                );

                if (confirm ?? false) {
                  return await endEvent(
                    onSuccess: () async {
                      await Dialogs.display(
                        context,
                        title: const Text('Evento encerrado'),
                        content: const Text(
                          'O evento foi encerrado com sucesso!',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      );

                      if (!context.mounted) return;

                      return context.pop();
                    },
                    onError: (error) {
                      return SnackBars.error(error);
                    },
                  );
                }
              },
            ),
          ],
        ],
      },
      child: Scaffold(
        appBar: switch (sharing) {
          true => null,
          false => AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => context.pop(),
            ),
            title: Text(event.name),
            actions: switch (event.ended) {
              true => [
                IconButton(
                  onPressed: () => shareEvent(onError: SnackBars.error),
                  icon: const Icon(Icons.share_rounded),
                ),
              ],
              false => null,
            },
          ),
        },
        body: switch (loading) {
          true => const Center(child: CircularProgressIndicator()),
          false => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: WidgetsToImage(
              controller: widgetsToImageController,
              child: Material(
                color: context.colorScheme.surface,
                child: Padding(
                  padding: const .all(16.0),
                  child: Column(
                    spacing: 16.0,
                    crossAxisAlignment: .stretch,
                    children: [
                      if (sharing) ...[
                        Text(
                          event.name,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: .bold,
                          ),
                        ),
                      ],
                      if (currentMatch != null &&
                          currentMatch?.ended == false) ...[
                        Text(
                          'Partida Atual',
                          textAlign: .start,
                          style: context.textTheme.titleMedium,
                        ),
                        CurrentMatchWidget(
                          match: currentMatch!,
                          onTap: () async {
                            await Match.push(context, currentMatch);

                            return await reloadEvent(
                              onError: SnackBars.error,
                              onMaxWinsInARow: onMaxWinsInARow,
                              onNeedJokers: onNeedJokers,
                            );
                          },
                        ),
                      ],
                      if (event.ended) ...[
                        Text(
                          'Placar final',
                          textAlign: .start,
                          style: context.textTheme.titleMedium,
                        ),
                        Table(
                          border: TableBorder.all(
                            color: context.colorScheme.surfaceContainerHighest,
                            width: 1.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(32.0),
                            1: FlexColumnWidth(1.0),
                            2: FixedColumnWidth(32.0),
                            3: FixedColumnWidth(32.0),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: context.colorScheme.onPrimary,
                              ),
                              children: List.from(
                                <String>['', 'Time', 'V', 'D'].indexed.map(
                                  (item) => TableCell(
                                    child: Padding(
                                      padding: const .all(8.0),
                                      child: Text(
                                        item.$2,
                                        textAlign: switch (item.$1 != 1) {
                                          true => .center,
                                          false => .start,
                                        },
                                        style: context.textTheme.bodyLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            for (final (index, team)
                                in event.sortedTeams.indexed) ...[
                              TableRow(
                                decoration: BoxDecoration(
                                  color: context.colorScheme.onPrimary,
                                ),
                                children: List.from(
                                  <String>[
                                    (index + 1).toString(),
                                    team.name,
                                    event.teamWins(team.id).toString(),
                                    event.teamLosses(team.id).toString(),
                                  ].indexed.map(
                                    (item) => TableCell(
                                      child: Padding(
                                        padding: const .all(8.0),
                                        child: Text(
                                          item.$2,
                                          textAlign: switch (item.$1 != 1) {
                                            true => .center,
                                            false => .start,
                                          },
                                          style: context.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                      if (!event.ended) ...[
                        Text(
                          'Próximo Jogo',
                          textAlign: .start,
                          style: context.textTheme.titleMedium,
                        ),
                        Text(
                          'Vencedor da ${currentMatch?.name} vs. ${event.teams.firstWhere((team) => team.id == event.queue.first).name}',
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          'Próximos Times (${event.queue.length})',
                          textAlign: .start,
                          style: context.textTheme.titleMedium,
                        ),
                        for (final (index, teamId) in event.queue.indexed) ...[
                          Text(
                            '${index + 1}. ${event.teams.firstWhere((team) => team.id == teamId).name}',
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ],
                      Text(
                        'Times (${event.teams.length})',
                        textAlign: .start,
                        style: context.textTheme.titleMedium,
                      ),
                      ListView.separated(
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 16.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: event.teams.length,
                        itemBuilder: (context, index) {
                          final team = event.teams[index];

                          return TeamCardWidget(
                            initiallyExpanded: sharing,
                            team: team,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        },
      ),
    );
  }
}
