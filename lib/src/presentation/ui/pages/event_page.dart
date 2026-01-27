import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/event_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/players_dialog.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.id, required this.controller});

  final String id;
  final EventController controller;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventController get controller => widget.controller;

  EventEntity get event => controller.event;

  MatchEntity get currentMatch => controller.currentMatch;

  TeamEntity get firstTeam => event.teams.firstWhere((team) => team.id == currentMatch.firstTeam.id);

  TeamEntity get secondTeam => event.teams.firstWhere((team) => team.id == currentMatch.secondTeam.id);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadDependencies(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (event.id != widget.id) {
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
                    _ => null,
                  };
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 0,
                      child: Text('Colar lista'),
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
                if (!currentMatch.ended) ...[
                  Text(
                    'Partida Atual',
                    style: context.textTheme.titleMedium,
                  ),
                  Material(
                    type: .transparency,
                    child: InkWell(
                      onTap: () async {
                        await context.pushNamed(
                          'match',
                          pathParameters: {
                            'matchId': currentMatch.id,
                          },
                        );

                        await controller.loadDependencies(widget.id);
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Card(
                        margin: .zero,
                        child: Column(
                          spacing: 16.0,
                          crossAxisAlignment: .stretch,
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 7,
                                  child: Image.asset(
                                    'assets/images/volei-bg.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 16.0,
                                  left: 16.0,
                                  right: 16.9,
                                  child: Text(
                                    currentMatch.name,
                                    style: context.textTheme.titleMedium?.copyWith(
                                      fontWeight: .bold,
                                      color: context.colorScheme.onPrimary,
                                    ),
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
                                      firstTeam.name,
                                      style: context.textTheme.titleMedium?.copyWith(
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                    Text(
                                      '${currentMatch.firstTeamScore}',
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
                                      secondTeam.name,
                                      style: context.textTheme.titleMedium?.copyWith(
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                    Text(
                                      '${currentMatch.secondTeamScore}',
                                      style: context.textTheme.displayLarge?.copyWith(
                                        fontWeight: .bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // const Divider(),
                            // if (currentMatch.lastScore.isNotEmpty) ...[
                            //   Text(
                            //     'Ultimo ponto: ${currentMatch.lastScore}',
                            //     style: context.textTheme.titleMedium,
                            //   ),
                            // ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                Text(
                  'Times',
                  style: context.textTheme.titleMedium,
                ),
                ListView.separated(
                  separatorBuilder: (_, _) => const SizedBox(height: 16.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: event.teams.length,
                  itemBuilder: (context, index) {
                    final team = event.teams[index];

                    return Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: context.theme.dividerColor,
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          spacing: 4.0,
                          crossAxisAlignment: .stretch,
                          children: [
                            Text(
                              team.name,
                              textAlign: .center,
                              style: context.textTheme.titleMedium,
                            ),
                            const Divider(),
                            for (final player in team.players) ...[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  spacing: 8.0,
                                  children: [
                                    SizedBox.square(
                                      dimension: 32.0,
                                      child: Material(
                                        shape: const CircleBorder(),
                                        color: switch (player.gender) {
                                          PlayerGenderMale _ => Colors.blue.withAlpha((255 * 0.1).toInt()),
                                          PlayerGenderFemale _ => Colors.pink.withAlpha((255 * 0.1).toInt()),
                                          _ => Colors.blueGrey.withAlpha((255 * 0.1).toInt()),
                                        },
                                        child: Padding(
                                          padding: const .all(4.0),
                                          child: switch (player.gender) {
                                            PlayerGenderMale _ => const Icon(
                                              Icons.male_rounded,
                                              color: Colors.blue,
                                              size: 22.0,
                                            ),
                                            PlayerGenderFemale _ => const Icon(
                                              Icons.female_rounded,
                                              color: Colors.pink,
                                              size: 22.0,
                                            ),
                                            _ => const Icon(
                                              Icons.person_rounded,
                                              color: Colors.blueGrey,
                                              size: 22.0,
                                            ),
                                          },
                                        ),
                                      ),
                                    ),
                                    Text(
                                      player.name,
                                      style: context.textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
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
