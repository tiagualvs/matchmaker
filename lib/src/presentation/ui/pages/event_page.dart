import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/event_controller.dart';
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

        return Scaffold(
          appBar: AppBar(
            title: Text(event.name),
            actions: [
              PopupMenuButton<int>(
                constraints: const BoxConstraints(minWidth: 196.0),
                onSelected: (value) async {
                  return switch (value) {
                    0 => context.pushNamed<void>(
                      'match-history',
                      pathParameters: {
                        'eventId': event.id.toString(),
                      },
                    ),
                    _ => null,
                  };
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 0,
                      child: Text('Histórico de partidas'),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Finalizar dia'),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const .all(16.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              spacing: 16.0,
              crossAxisAlignment: .stretch,
              children: [
                if (currentMatch?.ended == false) ...[
                  Text(
                    'Partida Atual',
                    textAlign: .start,
                    style: context.textTheme.titleMedium,
                  ),
                  Material(
                    type: .transparency,
                    child: InkWell(
                      onTap: () async {
                        await context.pushNamed(
                          'match',
                          pathParameters: {
                            'matchId': currentMatch?.id.toString() ?? '',
                          },
                        );
                        await controller.loadDependencies(widget.id);
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Card(
                        margin: .zero,
                        child: Column(
                          spacing: 8.0,
                          crossAxisAlignment: .stretch,
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 7,
                                  child: ShaderMask(
                                    shaderCallback: (bounds) {
                                      return const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent,
                                        ],
                                      ).createShader(bounds);
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Image.asset(
                                      'assets/images/volei-bg.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16.0,
                                  left: 16.0,
                                  right: 16.9,
                                  child: Text(
                                    currentMatch?.name ?? '--',
                                    style: context.textTheme.titleMedium?.copyWith(fontWeight: .bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 16.0,
                              mainAxisAlignment: .center,
                              children: [
                                Column(
                                  spacing: 4.0,
                                  crossAxisAlignment: .center,
                                  children: [
                                    Text(
                                      firstTeam?.name ?? '--',
                                      style: context.textTheme.titleMedium?.copyWith(
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                    Text(
                                      '${currentMatch?.firstTeamScore}',
                                      style: context.textTheme.displayLarge?.copyWith(
                                        fontWeight: .bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'vs',
                                  style: context.textTheme.titleMedium,
                                ),
                                Column(
                                  spacing: 4.0,
                                  crossAxisAlignment: .center,
                                  children: [
                                    Text(
                                      secondTeam?.name ?? '--',
                                      style: context.textTheme.titleMedium?.copyWith(
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                    Text(
                                      '${currentMatch?.secondTeamScore}',
                                      style: context.textTheme.displayLarge?.copyWith(
                                        fontWeight: .bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
