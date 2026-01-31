import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/presentation/controllers/teams_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/player_tile_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key, required this.eventId});

  final int eventId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TeamsController>()..resetController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.loadDependencies(eventId);
    });

    return Consumer<TeamsController>(
      builder: (context, _, _) {
        final teams = controller.teams;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Times'),
            actions: [
              IconButton(
                onPressed: () async {
                  if (controller.loading) return;

                  await context.pushNamed(
                    'teamAdd',
                    pathParameters: {'eventId': eventId.toString()},
                  );

                  await controller.loadDependencies(eventId, onError: SnackBars.error);
                },
                icon: const Icon(Symbols.group_add_rounded),
              ),
            ],
          ),
          body: switch (controller.loading) {
            true => const Center(
              child: CircularProgressIndicator(),
            ),
            false => ListView.separated(
              separatorBuilder: (_, _) => const SizedBox(height: 16.0),
              padding: const .all(24.0),
              itemCount: teams.length,
              itemBuilder: (context, i) {
                final team = teams[i];

                return Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.colorScheme.surfaceContainerHighest),
                  ),
                  child: Padding(
                    padding: const .symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        Padding(
                          padding: const .symmetric(horizontal: 16.0),
                          child: Text(
                            'Time ${team.name}',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                        for (final player in team.players) ...[
                          DragTarget<PlayerEntity>(
                            onAcceptWithDetails: (details) async {
                              await controller.changePlayers(
                                player,
                                details.data,
                                onSuccess: () => SnackBars.success('Jogadores trocados com sucesso!'),
                                onError: (err) => SnackBars.error(err),
                              );
                            },
                            builder: (context, candidateData, rejectedData) {
                              bool hasCandidate() {
                                if (candidateData.isEmpty) return false;
                                if (candidateData.contains(player)) return false;
                                return true;
                              }

                              Widget child({
                                bool feedback = false,
                                bool dragging = false,
                                bool hasCandidate = false,
                              }) => Material(
                                elevation: feedback ? 1.0 : 0.0,
                                color: switch (hasCandidate) {
                                  true => Colors.green.shade100,
                                  false => switch (dragging) {
                                    true => context.colorScheme.surfaceContainerHighest,
                                    false => null,
                                  },
                                },
                                child: SizedBox(
                                  height: kToolbarHeight,
                                  width: MediaQuery.sizeOf(context).width - 48,
                                  child: IntrinsicHeight(
                                    child: Padding(
                                      padding: const .symmetric(horizontal: 16.0),
                                      child: Row(
                                        spacing: 8.0,
                                        children: [
                                          const Icon(Symbols.drag_indicator_rounded),
                                          Expanded(child: PlayerTileWidget(player: player)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              return Draggable<PlayerEntity>(
                                data: player,
                                childWhenDragging: child(dragging: true, hasCandidate: hasCandidate()),
                                feedback: child(feedback: true),
                                child: child(hasCandidate: hasCandidate()),
                              );
                            },
                          ),
                        ],
                      ],
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
