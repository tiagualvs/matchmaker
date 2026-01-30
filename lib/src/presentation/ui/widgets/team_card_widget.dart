import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';

class TeamCardWidget extends StatefulWidget {
  const TeamCardWidget({
    super.key,
    required this.team,
    this.initiallyExpanded = false,
  });

  final bool initiallyExpanded;
  final TeamEntity team;

  @override
  State<TeamCardWidget> createState() => _TeamCardWidgetState();
}

class _TeamCardWidgetState extends State<TeamCardWidget> {
  final ExpansibleController controller = ExpansibleController();

  @override
  void didUpdateWidget(covariant TeamCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initiallyExpanded != widget.initiallyExpanded) {
      if (widget.initiallyExpanded) {
        controller.expand();
      } else {
        controller.collapse();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        controller: controller,
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
          'Time ${widget.team.name}',
          style: context.textTheme.titleMedium,
        ),
        children: List.from(
          widget.team.players.map(
            (player) => Padding(
              padding: const .only(bottom: 8.0),
              child: Row(
                spacing: 8.0,
                children: [
                  SizedBox(
                    width: 24.0,
                    child: switch (player.gender) {
                      PlayerGender.male => const Icon(Icons.male, color: Colors.blue),
                      PlayerGender.female => const Icon(Icons.female, color: Colors.pink),
                      _ => const Icon(Icons.info_outline_rounded),
                    },
                  ),
                  Expanded(
                    child: Text(
                      player.name,
                      textAlign: .start,
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                  switch (player.level) {
                    PlayerLevel.basic => const Text(
                      '⭐',
                      textAlign: .end,
                    ),
                    PlayerLevel.intermediate => const Text(
                      '⭐⭐',
                      textAlign: .end,
                    ),
                    PlayerLevel.advanced => const Text(
                      '⭐⭐⭐',
                      textAlign: .end,
                    ),
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
