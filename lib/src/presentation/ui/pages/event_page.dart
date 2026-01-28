import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/event_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/current_match_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/players_dialog.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.id, required this.controller});

  final int id;
  final EventController controller;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return await controller.loadDependencies(widget.id);
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
          menus: [
            FloatingActionButtonMenuItem(
              icon: const Icon(Icons.settings_rounded),
              label: const Text('Configurações'),
              onPressed: () => context.pushNamed(
                'event-settings',
                pathParameters: {
                  'eventId': event.id.toString(),
                },
              ),
            ),
            FloatingActionButtonMenuItem(
              icon: const Icon(Icons.list_rounded),
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
                onPressed: () {},
              ),
            ],
          ],
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => context.pop(),
              ),
              title: Text(event.name),
            ),
            body: SingleChildScrollView(
              padding: const .all(16.0),
              physics: const BouncingScrollPhysics(),
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: .stretch,
                children: [
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
                        await controller.loadDependencies(widget.id);
                      },
                    ),
                  ],
                  Text(
                    'Próximo Jogo',
                    textAlign: .start,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    'Vencedor da ${event.matches.first.name} vs. ${event.teams.firstWhere((team) => team.id == event.queue.first).name}',
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

                      return TeamCardWidget(team: team);
                    },
                  ),
                ],
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
