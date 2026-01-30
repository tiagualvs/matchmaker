import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/presentation/controllers/match_history_controller.dart';

class MatchHistoryPage extends StatefulWidget {
  const MatchHistoryPage({super.key, required this.eventId, required this.controller});

  final int eventId;
  final MatchHistoryController controller;

  @override
  State<MatchHistoryPage> createState() => _MatchHistoryPageState();
}

class _MatchHistoryPageState extends State<MatchHistoryPage> {
  MatchHistoryController get controller => widget.controller;

  EventEntity get event => controller.event;

  List<MatchEntity> get matches => event.matches.where((match) => match.ended).toList();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return await controller.loadDependencies(widget.eventId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        if (widget.controller.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Histórico de Partidas'),
          ),
          body: switch (matches.isEmpty) {
            true => Column(
              crossAxisAlignment: .stretch,
              mainAxisAlignment: .center,
              children: [
                const Icon(
                  Icons.event,
                  size: 92.0,
                ),
                Text(
                  'Nenhuma partida encontrada',
                  textAlign: .center,
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
            false => ListView.separated(
              separatorBuilder: (_, _) => const SizedBox(height: 16.0),
              padding: const .all(16.0),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];

                return ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 16.0),
                  expandedCrossAxisAlignment: .stretch,
                  backgroundColor: context.colorScheme.onPrimary,
                  collapsedBackgroundColor: context.colorScheme.onPrimary,
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: context.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: context.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  title: Text(
                    '${match.firstTeam.name} (${match.firstTeamScore}) x (${match.secondTeamScore}) ${match.secondTeam.name}',
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: .normal),
                  ),
                  children: List.from(
                    match.scores.map(
                      (score) {
                        final currentPoint = match.scores.where(
                          (s) =>
                              s.teamId == score.teamId &&
                              (s.id >= score.id &&
                                  (s.createdAt.isAtSameMomentAs(score.createdAt) ||
                                      s.createdAt.isAfter(score.createdAt))) &&
                              !s.reversed,
                        );

                        return Container(
                          padding: const .all(8.0),
                          margin: const .only(bottom: 8.0),
                          color: score.teamId == match.firstTeam.id ? Colors.blue.shade100 : Colors.red.shade100,
                          child: Row(
                            spacing: 8.0,
                            children: [
                              Text(
                                '(${currentPoint.length})',
                                style: context.textTheme.bodyMedium?.copyWith(fontWeight: .bold),
                              ),
                              Expanded(
                                child: Text(
                                  score.teamId == match.firstTeam.id ? match.firstTeam.name : match.secondTeam.name,
                                  maxLines: 1,
                                  overflow: .ellipsis,
                                  style: context.textTheme.bodyMedium?.copyWith(fontWeight: .bold),
                                ),
                              ),
                              Text(DateFormat('HH:mm').format(score.createdAt)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          },
        );
      },
    );
  }
}
