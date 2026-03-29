import 'dart:core' hide Match;

import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/extensions/num_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/others/dialogs.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/others/text_span_builder.dart';
import 'package:matchmaker/src/common/shared/id.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/presentation/event_settings/event_settings.dart';
import 'package:matchmaker/src/presentation/match/match.dart';
import 'package:matchmaker/src/presentation/match_history/match_history.dart';
import 'package:matchmaker/src/presentation/teams/teams.dart';
import 'package:matchmaker/src/presentation/ui/widgets/current_match_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'event_view_model.dart';

class EventView extends EventViewModel {
  Future<void> onNeedJokers(String message) async {
    return await Dialogs.display(
      context,
      title: Text(L10n.of(context).playerMissing),
      content: Text.rich(
        TextSpanBuilder.build(
          message,
          normalStyle: context.textTheme.bodyLarge,
          boldStyle: context.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(L10n.of(context).ok),
        ),
      ],
    );
  }

  Future<void> onMaxWinsInARow(String message) async {
    return await Dialogs.display(
      context,
      title: Text(
        L10n.of(context).maxWinsReached,
        style: context.textTheme.headlineMedium?.copyWith(fontWeight: .bold),
      ),
      content: Text.rich(
        TextSpanBuilder.build(
          message,
          normalStyle: context.textTheme.bodyLarge,
          boldStyle: context.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(L10n.of(context).ok),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButtonMenu(
      menus: switch (sharing) {
        true => [],
        false => [
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.settings_rounded),
            label: Text(L10n.of(context).settings),
            onPressed: () async {
              await EventSettings.push(context, event.id);

              return await reloadEvent(
                onError: SnackBars.error,
                onMaxWinsInARow: onMaxWinsInARow,
                onNeedJokers: onNeedJokers,
              );
            },
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.list_rounded),
            label: Text(L10n.of(context).matchHistory),
            onPressed: () async {
              await MatchHistory.push(context, event.id);

              return await reloadEvent(
                onError: SnackBars.error,
                onMaxWinsInARow: onMaxWinsInARow,
                onNeedJokers: onNeedJokers,
              );
            },
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.groups_rounded),
            label: Text(L10n.of(context).adjustTeams),
            onPressed: () async {
              await Teams.push(context, event.id);

              return await reloadEvent(
                onError: SnackBars.error,
                onMaxWinsInARow: onMaxWinsInARow,
                onNeedJokers: onNeedJokers,
              );
            },
          ),
          if (!event.ended) ...[
            FloatingActionButtonMenuItem(
              icon: const Icon(Icons.flag_rounded),
              label: Text(L10n.of(context).endEvent),
              onPressed: () async {
                final hasEndedMatches = event.endedMatches.isNotEmpty;

                final confirm = await Dialogs.display(
                  context,
                  title: Text(L10n.of(context).endEventQuestion),
                  content: Text(
                    L10n.of(context).endEventConfirmation(
                      hasEndedMatches.toString(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(L10n.of(context).no),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(L10n.of(context).yes),
                    ),
                  ],
                );

                if (confirm ?? false) {
                  return await endEvent(
                    onSuccess: () async {
                      await Dialogs.display(
                        context,
                        title: Text(L10n.of(context).eventClosed),
                        content: Text(
                          L10n.of(context).eventClosedSuccess,
                        ),
                        actions: [
                          TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text(L10n.of(context).ok),
                          ),
                        ],
                      );

                      if (!context.mounted) return;

                      return Navigator.of(context).pop();
                    },
                    onError: (error) {
                      return SnackBars.error(error);
                    },
                  );
                }
              },
            ),
          ],
        ],
      },
      child: Scaffold(
        appBar: switch (sharing) {
          true => null,
          false => AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: Navigator.of(context).pop,
            ),
            title: Text(event.name),
            actions: switch (event.ended) {
              true => [
                IconButton(
                  onPressed: () => shareEvent(onError: SnackBars.error),
                  icon: const Icon(Icons.share_rounded),
                ),
              ],
              false => null,
            },
          ),
        },
        body: switch (loading) {
          true => const Center(child: CircularProgressIndicator()),
          false => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: WidgetsToImage(
              controller: widgetsToImageController,
              child: Material(
                color: context.colorScheme.surface,
                child: Padding(
                  padding: .all(2.unit),
                  child: Column(
                    spacing: 2.unit,
                    crossAxisAlignment: .stretch,
                    children: [
                      if (sharing) ...[
                        Text(
                          event.name,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: .bold,
                          ),
                        ),
                      ],
                      if (currentMatch != null &&
                          currentMatch?.ended == false) ...[
                        Text(
                          L10n.of(context).currentMatch,
                          textAlign: .start,
                          style: context.textTheme.titleMedium,
                        ),
                        CurrentMatchWidget(
                          match: currentMatch!,
                          onTap: () async {
                            await Match.push(
                              context,
                              event.id,
                              currentMatch?.id ?? Id.max(),
                            );

                            return await reloadEvent(
                              onError: SnackBars.error,
                              onMaxWinsInARow: onMaxWinsInARow,
                              onNeedJokers: onNeedJokers,
                            );
                          },
                        ),
                      ],
                      if (event.ended) ...[
                        Text(
                          L10n.of(context).finalScore,
                          textAlign: .start,
                          style: context.textTheme.titleMedium,
                        ),
                        Table(
                          border: TableBorder.all(
                            color: context.colorScheme.surfaceContainerHighest,
                            width: 1.0,
                            borderRadius: BorderRadius.circular(1.unit),
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(32.0),
                            1: FlexColumnWidth(1.0),
                            2: FixedColumnWidth(32.0),
                            3: FixedColumnWidth(32.0),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: context.colorScheme.onPrimary,
                              ),
                              children: List.from(
                                <String>[
                                  '',
                                  L10n.of(context).team,
                                  L10n.of(context).winsAbbreviation,
                                  L10n.of(context).lossesAbbreviation,
                                ].indexed.map(
                                  (item) => TableCell(
                                    child: Padding(
                                      padding: .all(1.unit),
                                      child: Text(
                                        item.$2,
                                        textAlign: switch (item.$1 != 1) {
                                          true => .center,
                                          false => .start,
                                        },
                                        style: context.textTheme.bodyLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            for (final (index, team)
                                in event.sortedTeams.indexed) ...[
                              TableRow(
                                decoration: BoxDecoration(
                                  color: context.colorScheme.onPrimary,
                                ),
                                children: List.from(
                                  <String>[
                                    (index + 1).toString(),
                                    team.name,
                                    event.teamWins(team.id).toString(),
                                    event.teamLosses(team.id).toString(),
                                  ].indexed.map(
                                    (item) => TableCell(
                                      child: Padding(
                                        padding: .all(1.unit),
                                        child: Text(
                                          item.$2,
                                          textAlign: switch (item.$1 != 1) {
                                            true => .center,
                                            false => .start,
                                          },
                                          style: context.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                      if (!event.ended) ...[
                        Text(
                          L10n.of(context).nextGame,
                          textAlign: .start,
                          style: context.textTheme.titleMedium,
                        ),
                        Text(
                          L10n.of(context).nextGameDescription(
                            currentMatch?.name ?? '',
                            event.teams
                                .firstWhere(
                                  (team) => team.id == event.queue.first,
                                )
                                .name,
                          ),
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          L10n.of(context).nextTeamsCount(event.queue.length),
                          textAlign: .start,
                          style: context.textTheme.titleMedium,
                        ),
                        for (final (index, teamId) in event.queue.indexed) ...[
                          Text(
                            '${index + 1}. ${event.teams.firstWhere((team) => team.id == teamId).name}',
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ],
                      Text(
                        L10n.of(context).teamsCount(event.teams.length),
                        textAlign: .start,
                        style: context.textTheme.titleMedium,
                      ),
                      ListView.separated(
                        separatorBuilder: (_, _) => SizedBox(height: 2.unit),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: event.teams.length,
                        itemBuilder: (context, index) {
                          final team = event.teams[index];

                          return TeamCardWidget(
                            initiallyExpanded: sharing,
                            team: team,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        },
      ),
    );
  }
}
