import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/dialogs.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/others/text_span_builder.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/event_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/current_match_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/players_dialog.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.id, required this.controller});

  final int id;
  final EventController controller;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final WidgetsToImageController widgetsToImageController = WidgetsToImageController();

  EventController get controller => widget.controller;

  EventEntity get event => controller.event;

  MatchEntity? get currentMatch => event.currentMatch;

  TeamEntity? get firstTeam {
    if (currentMatch == null) return null;

    final index = event.teams.indexWhere((team) => team.id == currentMatch?.firstTeam.id);

    if (index == -1) return null;

    return event.teams[index];
  }

  TeamEntity? get secondTeam {
    if (currentMatch == null) return null;

    final index = event.teams.indexWhere((team) => team.id == currentMatch?.secondTeam.id);

    if (index == -1) return null;

    return event.teams[index];
  }

  Future<void> whenMaxWinsInARow(
    TeamEntity winner,
    TeamEntity firstTeam,
    TeamEntity secondTeam,
  ) async {
    return await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Máximo de vitórias atingida!',
            style: context.textTheme.headlineMedium?.copyWith(fontWeight: .bold),
          ),
          content: Text.rich(
            TextSpanBuilder.build(
              'O time [b]${winner.name}[/b] alcançou o número máximo de vitórias em sequência [b](${event.maxWinsInARow})[/b].\n\nAgora dará lugar ao próximo time e voltará para a fila com prioridade para jogar a próxima partida!\n\nPróximo jogo:\n[b]${firstTeam.name}[/b] vs. [b]${secondTeam.name}[/b]!',
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
      },
    );
  }

  Future<void> onNeedsJoker(TeamEntity team, List<PlayerEntity> suggestions) async {
    return await Dialogs.show(
      context,
      title: 'Jogador ausente!',
      content:
          'O time [b]${team.name}[/b] precisa de ${event.maxPlayerPerTeam - team.players.length} jogadores para completar a equipe!${suggestions.isNotEmpty ? '\n\nJogadores sugeridos:\n${suggestions.map((player) => player.name).join('\n')}' : ''}',
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return await controller.loadDependencies(
        widget.id,
        onMaxWinsInARow: whenMaxWinsInARow,
        onNeedsJoker: onNeedsJoker,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (event.id != widget.id || controller.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return FloatingActionButtonMenu(
          menus: switch (controller.sharing) {
            true => [],
            false => [
              FloatingActionButtonMenuItem(
                icon: const Icon(Symbols.settings_rounded),
                label: const Text('Configurações'),
                onPressed: () async {
                  await context.pushNamed(
                    'event-settings',
                    pathParameters: {
                      'eventId': event.id.toString(),
                    },
                  );

                  return controller.loadDependencies(
                    widget.id,
                    onMaxWinsInARow: whenMaxWinsInARow,
                    onNeedsJoker: onNeedsJoker,
                  );
                },
              ),
              FloatingActionButtonMenuItem(
                icon: const Icon(Symbols.list_rounded),
                label: const Text('Histórico de partidas'),
                onPressed: () => context.pushNamed(
                  'match-history',
                  pathParameters: {
                    'eventId': event.id.toString(),
                  },
                ),
              ),
              if (!event.ended) ...[
                FloatingActionButtonMenuItem(
                  icon: const Icon(Icons.flag_rounded),
                  label: const Text('Finalizar evento'),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Finalizar evento?',
                            style: context.textTheme.headlineMedium?.copyWith(fontWeight: .bold),
                          ),
                          content: Text(
                            'Tem certeza que deseja finalizar este evento?\n\nTodas as partidas em andamento serão canceladas.\n\nEssa ação não poderá ser desfeita!\n\nDeseja prosseguir?',
                            style: context.textTheme.bodyLarge,
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
                      },
                    );

                    if (confirm ?? false) {
                      return await controller.endEvent(
                        onSuccess: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Evento finalizado!',
                                  style: context.textTheme.headlineMedium?.copyWith(fontWeight: .bold),
                                ),
                                content: Text(
                                  'O evento foi finalizado com sucesso!',
                                  style: context.textTheme.bodyLarge,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
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
            appBar: switch (controller.sharing) {
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
                      onPressed: () => controller.shareEvent(widgetsToImageController, onError: SnackBars.error),
                      icon: const Icon(Icons.share_rounded),
                    ),
                  ],
                  false => null,
                },
              ),
            },
            body: SingleChildScrollView(
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
                        if (controller.sharing) ...[
                          Text(
                            event.name,
                            style: context.textTheme.titleMedium?.copyWith(fontWeight: .bold),
                          ),
                        ],
                        if (currentMatch != null && currentMatch?.ended == false) ...[
                          Text(
                            'Partida Atual',
                            textAlign: .start,
                            style: context.textTheme.titleMedium,
                          ),
                          CurrentMatchWidget(
                            match: currentMatch!,
                            onTap: () async {
                              await context.pushNamed(
                                'match',
                                pathParameters: {
                                  'matchId': currentMatch?.id.toString() ?? '',
                                },
                              );
                              await controller.loadDependencies(
                                widget.id,
                                onMaxWinsInARow: whenMaxWinsInARow,
                                onNeedsJoker: onNeedsJoker,
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
                                decoration: BoxDecoration(color: context.colorScheme.onPrimary),
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
                              for (final (index, team) in event.sortedTeams.indexed) ...[
                                TableRow(
                                  decoration: BoxDecoration(color: context.colorScheme.onPrimary),
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
                            'Próximos Times',
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
                          separatorBuilder: (_, _) => const SizedBox(height: 16.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: event.teams.length,
                          itemBuilder: (context, index) {
                            final team = event.teams[index];

                            return TeamCardWidget(
                              initiallyExpanded: controller.sharing,
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
          ),
        );
      },
    );
  }

  Future<List<PlayerEntity>?> showPlayersDialog(BuildContext context, List<PlayerEntity> players) async {
    return showDialog<List<PlayerEntity>>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: .zero,
          child: PlayersDialog(players: players),
        );
      },
    );
  }
}
