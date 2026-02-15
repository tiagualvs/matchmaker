import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/dialogs.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/others/text_span_builder.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/add_player/add_player.dart';
import 'package:matchmaker/src/presentation/ui/widgets/player_input_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/player_tile_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'teams_view_model.dart';

class TeamsView extends TeamsViewModel {
  void handleDeleteTeam(TeamEntity team) async {
    final confirm = await Dialogs.display(
      context,
      title: const Text('Remover Time?'),
      content: Text.rich(
        TextSpanBuilder.build(
          'Tem certeza que deseja remover o time [b]${team.name}[/b] deste evento?\n\nEssa ação não poderá ser desfeita!',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.error,
          ),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: const Text('Remover'),
        ),
      ],
    );

    if (confirm ?? false) {
      return await deleteTeam(
        team.id,
        onError: SnackBars.error,
      );
    }
  }

  Future<void> handleInsertPlayer(int index, int teamId) async {
    final player = await showModalBottomSheet<PlayerEntity>(
      context: context,
      isScrollControlled: true,
      builder: (context) => PlayerInputWidget(
        onSave: (value) => context.pop(value),
        withLevelSelect: false,
      ),
    );

    if (player == null) return;

    return await insertPlayer(
      index,
      teamId,
      player,
      onError: SnackBars.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Times'),
        actions: [
          IconButton(
            onPressed: () async {
              if (loading) return;

              await AddPlayer.push(context, event);

              await loadDependencies(onError: SnackBars.error);
            },
            icon: const Icon(Symbols.group_add_rounded),
          ),
        ],
      ),
      body: switch (loading) {
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
                side: BorderSide(
                  color: context.colorScheme.surfaceContainerHighest,
                ),
              ),
              child: Padding(
                padding: const .symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Padding(
                      padding: const .only(left: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Time ${team.name}',
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () => handleDeleteTeam(team),
                            icon: const Icon(Symbols.delete_rounded),
                          ),
                        ],
                      ),
                    ),
                    for (final (j, player) in team.players.indexed) ...[
                      if (player.isJoker) ...[
                        playerWidget(
                          context,
                          player,
                          onTap: () => handleInsertPlayer(j, team.id),
                        ),
                      ],
                      if (!player.isJoker) ...[
                        DragTarget<PlayerEntity>(
                          onAcceptWithDetails: (details) async {
                            await changePlayers(
                              player,
                              details.data,
                              onSuccess: () => SnackBars.success(
                                'Jogadores trocados com sucesso!',
                              ),
                              onError: (err) => SnackBars.error(err),
                            );
                          },
                          builder: (context, candidateData, rejectedData) {
                            bool hasCandidate() {
                              if (candidateData.isEmpty) return false;
                              if (candidateData.contains(player)) return false;
                              return true;
                            }

                            return Draggable<PlayerEntity>(
                              data: player,
                              childWhenDragging: playerWidget(
                                context,
                                player,
                                dragging: true,
                                hasCandidate: hasCandidate(),
                              ),
                              feedback: playerWidget(
                                context,
                                player,
                                feedback: true,
                              ),
                              child: playerWidget(
                                context,
                                player,
                                hasCandidate: hasCandidate(),
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      },
    );
  }

  Widget playerWidget(
    BuildContext context,
    PlayerEntity player, {
    void Function()? onTap,
    void Function()? onLongPress,
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
    child: InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
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
    ),
  );
}
