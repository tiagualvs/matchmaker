import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/extensions/num_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/ui/widgets/player_input_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/player_tile_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'add_player_view_model.dart';

class AddPlayerView extends AddPlayerViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).addTeam),
        actions: switch (players.length != event.maxPlayerPerTeam) {
          true => [
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) {
                  return PlayerInputWidget(
                    withLevelSelect: false,
                    onSave: (player) async {
                      context.pop();

                      return await handleInsertPlayer(
                        player,
                        onError: SnackBars.error,
                      );
                    },
                  );
                },
              ),
              icon: const Icon(Symbols.person_add_rounded),
            ),
          ],
          false => [],
        },
      ),
      body: switch (loading) {
        true => const Center(child: CircularProgressIndicator()),
        false => SingleChildScrollView(
          padding: .all(3.unit),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 2.unit,
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  L10n.of(context).registerTeam,
                  style: context.textTheme.titleMedium,
                ),
                DropdownMenuFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return L10n.of(context).selectTeamNameError;
                    }

                    return null;
                  },
                  initialSelection: team.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  width: MediaQuery.sizeOf(context).width - 41.unit,
                  dropdownMenuEntries: List.from(
                    TeamEntity.names
                        .where(
                          (name) => !event.teams
                              .map((team) => team.name)
                              .contains(name),
                        )
                        .map(
                          (name) => DropdownMenuEntry(value: name, label: name),
                        ),
                  ),
                  onSelected: (value) {
                    if (value == null) return;

                    return setName(value);
                  },
                  hintText: L10n.of(context).selectPlaceholder,
                  label: Text(L10n.of(context).teamNameLabel),
                  inputDecorationTheme: context.theme.inputDecorationTheme
                      .copyWith(
                        floatingLabelBehavior: .always,
                      ),
                ),
                if (players.isNotEmpty) ...[
                  Text(
                    L10n.of(context).playersLabel,
                    style: context.textTheme.titleMedium,
                  ),
                  for (final player in players) ...[
                    PlayerTileWidget(player: player),
                  ],
                ],
              ],
            ),
          ),
        ),
      },
      bottomNavigationBar: Padding(
        padding: .all(3.unit),
        child: FilledButton.icon(
          key: const ValueKey('TeamAddPage.saveButton'),
          onPressed: switch (team.players.isEmpty) {
            true => null,
            false => () => save(
              onSuccess: () {
                SnackBars.success(L10n.of(context).teamRegisteredSuccess);
                return context.pop();
              },
              onError: (err) {
                return SnackBars.error(err);
              },
            ),
          },
          icon: const Icon(Symbols.save_rounded),
          label: Text(L10n.of(context).saveTeam),
        ),
      ),
    );
  }
}
