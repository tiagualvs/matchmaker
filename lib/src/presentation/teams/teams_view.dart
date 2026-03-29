import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/extensions/num_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
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
      title: Text(L10n.of(context).removeTeamQuestion),
      content: Text.rich(
        TextSpanBuilder.build(
          L10n.of(context).removeTeamConfirmation(team.name),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.error,
          ),
          child: Text(L10n.of(context).cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(L10n.of(context).remove),
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

  Future<void> handleInsertPlayer(int index, String teamId) async {
    final player = await showModalBottomSheet<PlayerEntity>(
      context: context,
      isScrollControlled: true,
      builder: (context) => PlayerInputWidget(
        onSave: context.pop,
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
        title: Text(L10n.of(context).teamsLabel),
        actions: [
          IconButton(
            onPressed: () async {
              if (loading) return;

              final team = await AddPlayer.push<TeamEntity>(context, event.id);

              return teamsNormalizer(team);
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
          separatorBuilder: (_, _) => SizedBox(height: 2.unit),
          padding: .all(3.unit),
          itemCount: teams.length,
          itemBuilder: (context, i) {
            final team = teams[i];

            return Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.unit),
                side: BorderSide(
                  color: context.colorScheme.surfaceContainerHighest,
                ),
              ),
              child: Padding(
                padding: .symmetric(vertical: 2.unit),
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Padding(
                      padding: .only(left: 2.unit),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              L10n.of(context).teamNameTitle(team.name),
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
                                L10n.of(context).playersSwappedSuccess,
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
            padding: .symmetric(horizontal: 2.unit),
            child: Row(
              spacing: 1.unit,
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
