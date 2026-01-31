import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:material_symbols_icons/symbols.dart';

class PlayerTileWidget extends StatelessWidget {
  const PlayerTileWidget({
    super.key,
    required this.player,
    this.showGender = true,
    this.showLevel = true,
  });

  final PlayerEntity player;
  final bool showGender;
  final bool showLevel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(bottom: 8.0),
      child: Row(
        spacing: 8.0,
        children: [
          if (showGender) ...[
            SizedBox(
              width: 24.0,
              child: switch (player.gender) {
                PlayerGender.male => const Icon(Symbols.male, color: Colors.blue),
                PlayerGender.female => const Icon(Symbols.female, color: Colors.pink),
                _ => const Icon(Symbols.agender),
              },
            ),
          ],
          Expanded(
            child: Text(
              player.name,
              textAlign: .start,
              style: context.textTheme.bodyMedium,
            ),
          ),
          if (showLevel) ...[
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
        ],
      ),
    );
  }
}
