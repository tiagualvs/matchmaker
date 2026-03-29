import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/extensions/num_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/presentation/ui/widgets/event_settings_dialog.dart';
import 'package:matchmaker/src/presentation/ui/widgets/player_input_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'create_event_view_model.dart';

class CreateEventView extends CreateEventViewModel {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButtonMenu(
      menus: [
        FloatingActionButtonMenuItem(
          icon: const Icon(Symbols.settings_rounded),
          label: Text(L10n.of(context).eventSettings),
          onPressed: () async {
            final changedEvent = await showGeneralDialog<EventEntity>(
              context: context,
              pageBuilder: (context, animation, _) {
                return FadeTransition(
                  opacity: animation,
                  child: EventSettingsDialog(event: event),
                );
              },
            );

            if (changedEvent != null) {
              handleEventChanges(changedEvent);
            }
          },
        ),
        if (event.teams.isNotEmpty) ...[
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.refresh_rounded),
            label: Text(L10n.of(context).undoTeams),
            onPressed: () => handleEventChanges(
              event.copyWith(teams: []),
            ),
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.shuffle_rounded),
            label: Text(L10n.of(context).regenerateTeams),
            onPressed: () => handleGenerateTeams(
              onError: SnackBars.error,
            ),
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.save_rounded),
            label: Text(L10n.of(context).saveEvent),
            onPressed: () => handleSaveEvent(
              onSuccess: () {
                Navigator.of(context).pop(true);

                return SnackBars.success(L10n.of(context).eventSavedSuccess);
              },
              onError: (error) {
                return SnackBars.error(error);
              },
            ),
          ),
        ],
        if (event.teams.isEmpty) ...[
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.groups_rounded),
            label: Text(L10n.of(context).importPlayersFromList),
            onPressed: () async {
              String? initialValue;

              final list = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: EdgeInsets.all(3.unit),
                        child: Column(
                          spacing: 2.unit,
                          crossAxisAlignment: .stretch,
                          mainAxisSize: .min,
                          children: [
                            Text(
                              L10n.of(context).importPlayers,
                              style: context.textTheme.titleMedium,
                            ),
                            TextFormField(
                              minLines: 5,
                              maxLines: 7,
                              initialValue: initialValue,
                              onChanged: (value) =>
                                  setState(() => initialValue = value),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText:
                                    '1 - Fulano de Tal - H\n2 - Sicrano de Tal\n3 - Elma Maria - M',
                                labelText: L10n.of(context).playerList,
                                floatingLabelBehavior: .always,
                              ),
                            ),
                            FilledButton.icon(
                              key: const ValueKey(
                                'CreateEventPage.importButton',
                              ),
                              onPressed: initialValue == null
                                  ? null
                                  : () => context.pop(initialValue),
                              icon: const Icon(Symbols.upload_file_rounded),
                              label: Text(L10n.of(context).importLabel),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );

              if (list == null) return;

              return await importFromRawList(
                list,
                onError: SnackBars.error,
              );
            },
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.person_add_rounded),
            label: Text(L10n.of(context).addPlayer),
            onPressed: () async {
              final player = await showModalBottomSheet<PlayerEntity>(
                context: context,
                builder: (context) {
                  return PlayerInputWidget(
                    onSave: Navigator.of(context).pop,
                    withLevelSelect: false,
                  );
                },
              );

              if (player == null) return;

              return await handleAddPlayer(
                player,
                onError: SnackBars.error,
              );
            },
          ),
        ],
        if (teams.isEmpty && players.isNotEmpty) ...[
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.groups_rounded),
            label: Text(L10n.of(context).generateTeams),
            onPressed: () => handleGenerateTeams(onError: SnackBars.error),
          ),
        ],
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Symbols.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(event.name),
        ),
        body: switch (loading) {
          true => const Center(child: CircularProgressIndicator()),
          false when teams.isEmpty && players.isEmpty => Column(
            crossAxisAlignment: .stretch,
            mainAxisSize: .max,
            mainAxisAlignment: .center,
            children: [
              Icon(
                Symbols.groups_rounded,
                size: 64.0,
                color: context.colorScheme.primary,
              ),
              SizedBox(height: 2.unit),
              Text(
                L10n.of(context).noTeamsRegistered,
                textAlign: .center,
                style: context.textTheme.titleMedium,
              ),
              Text(
                L10n.of(context).addPlayersToCreateTeams,
                textAlign: .center,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          false when teams.isEmpty && players.isNotEmpty =>
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(3.unit),
              child: Column(
                spacing: 2.unit,
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    L10n.of(context).playersCount(players.length),
                    style: context.textTheme.titleMedium,
                  ),
                  for (final (index, player) in players.indexed) ...[
                    Material(
                      clipBehavior: .antiAlias,
                      color: context.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(1.unit),
                        ),
                        side: BorderSide(
                          width: 0.5,
                          color: context.colorScheme.primaryFixed,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          final changedPlayed =
                              await showModalBottomSheet<PlayerEntity>(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => PlayerInputWidget(
                                  player: player,
                                  onSave: Navigator.of(context).pop,
                                ),
                              );

                          if (changedPlayed == null) return;

                          await handlePlayerChanges(
                            index,
                            changedPlayed,
                            onError: SnackBars.error,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.5.unit,
                            horizontal: 2.unit,
                          ).copyWith(right: 0.unit),
                          child: Row(
                            spacing: 2.unit,
                            children: [
                              Material(
                                shape: const CircleBorder(),
                                color: switch (player.gender) {
                                  PlayerGender.male => Colors.blue.withAlpha(
                                    (255 * 0.1).toInt(),
                                  ),
                                  PlayerGender.female => Colors.pink.withAlpha(
                                    (255 * 0.1).toInt(),
                                  ),
                                  _ => Colors.blueGrey.withAlpha(
                                    (255 * 0.1).toInt(),
                                  ),
                                },
                                child: Padding(
                                  padding: const .all(4.0),
                                  child: switch (player.gender) {
                                    PlayerGender.male => const Icon(
                                      Symbols.male_rounded,
                                      color: Colors.blue,
                                      size: 22.0,
                                    ),
                                    PlayerGender.female => const Icon(
                                      Symbols.female_rounded,
                                      color: Colors.pink,
                                      size: 22.0,
                                    ),
                                    _ => const Icon(
                                      Symbols.agender_rounded,
                                      color: Colors.blueGrey,
                                      size: 22.0,
                                    ),
                                  },
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  player.name,
                                  style: context.textTheme.titleMedium,
                                ),
                              ),
                              IconButton(
                                onPressed: () => handleRemovePlayer(index),
                                icon: const Icon(Symbols.delete_rounded),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          false when teams.isNotEmpty => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(3.unit),
            child: Column(
              spacing: 2.unit,
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  L10n.of(context).teamsCount(teams.length),
                  style: context.textTheme.titleMedium,
                ),
                for (final team in teams) ...[
                  TeamCardWidget(team: team, initiallyExpanded: true),
                ],
              ],
            ),
          ),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
