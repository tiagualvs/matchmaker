import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/others/dialogs.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/others/text_span_builder.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';

import 'match_view_model.dart';

class MatchView extends MatchViewModel {
  Future<bool> confirmEndOfMatch(
    BuildContext context, {
    required TeamEntity team,
    required String score,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                L10n.of(context).endOfMatch,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: .bold,
                ),
              ),
              content: Text.rich(
                TextSpanBuilder.build(
                  L10n.of(context).matchWonMessage(team.name, score),
                  normalStyle: context.textTheme.bodyLarge,
                  boldStyle: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: .bold,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: TextButton.styleFrom(
                    foregroundColor: context.colorScheme.error,
                  ),
                  child: Text(L10n.of(context).noRevert),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(L10n.of(context).yesConfirm),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final firstTeamWidget = Expanded(
      child: GestureDetector(
        onTap: () => incrementScore(
          firstTeam.id,
          confirmEndOfMatch: (team, score) => confirmEndOfMatch(
            context,
            team: team,
            score: score,
          ),
          onError: (error) {
            return SnackBars.error(error);
          },
        ),
        onVerticalDragEnd: (details) async {
          if (details.velocity.pixelsPerSecond.dy > 8) {
            return reverseScore(
              firstTeam.id,
              onError: (error) {
                return SnackBars.error(error);
              },
            );
          }
        },
        child: Material(
          color: Colors.blue,
          elevation: 0.0,
          child: Column(
            children: [
              Expanded(
                child: FittedBox(
                  child: Text(
                    firstTeamScore.toString(),
                    style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: .bold,
                      shadows: [
                        const Shadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                      color: switch (firstTeamByOneOrWon) {
                        true => Colors.yellow,
                        false => Colors.white,
                      },
                      // fontSize: 256.0,
                    ),
                  ),
                ),
              ),
              Text(
                firstTeam.name,
                textAlign: .center,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: .bold,
                  color: Colors.white,
                ),
              ),
              Text(
                firstTeam.playersNames,
                textAlign: .center,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: .normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final secondTeamWidget = Expanded(
      child: GestureDetector(
        onTap: () => incrementScore(
          secondTeam.id,
          confirmEndOfMatch: (team, score) => confirmEndOfMatch(
            context,
            team: team,
            score: score,
          ),
          onError: (error) {
            return SnackBars.error(error);
          },
        ),
        onVerticalDragEnd: (details) async {
          if (details.velocity.pixelsPerSecond.dy > 8) {
            return reverseScore(
              secondTeam.id,
              onError: (error) {
                return SnackBars.error(error);
              },
            );
          }
        },
        child: Material(
          color: Colors.red,
          elevation: 0.0,
          child: Column(
            children: [
              Expanded(
                child: FittedBox(
                  child: Text(
                    secondTeamScore.toString(),
                    style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: .bold,
                      shadows: [
                        const Shadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                      color: switch (secondTeamByOneOrWon) {
                        true => Colors.yellow,
                        false => Colors.white,
                      },
                    ),
                  ),
                ),
              ),
              Text(
                secondTeam.name,
                textAlign: .center,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: .bold,
                  color: Colors.white,
                ),
              ),
              Text(
                secondTeam.playersNames,
                textAlign: .center,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: .normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (match.ended && match.isDetached) {
        final confirm = await Dialogs.show(
          context,
          title: L10n.of(context).endOfMatch,
          content: L10n.of(context).startNewMatchQuestion,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                foregroundColor: context.colorScheme.error,
              ),
              child: Text(L10n.of(context).no),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(L10n.of(context).yes),
            ),
          ],
        );

        if (!context.mounted) return;

        if (confirm ?? false) return restartDetachedMatch();

        return Navigator.of(context).pop();
      }

      if (match.ended) return Navigator.of(context).pop();
    });

    return SafeArea(
      child: Scaffold(
        body: switch (loading) {
          true => const Center(child: CircularProgressIndicator()),
          false => Stack(
            children: [
              Row(
                spacing: 16.0,
                children: switch (swapped) {
                  true => [secondTeamWidget, firstTeamWidget],
                  false => [firstTeamWidget, secondTeamWidget],
                },
              ),
              Positioned(
                top: 16.0,
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    if (match.isDetached) ...[
                      FloatingActionButton(
                        heroTag: 'settings',
                        onPressed: () async {
                          await Dialogs.display(
                            context,
                            constraints: const BoxConstraints(
                              minWidth: 480.0,
                            ),
                            title: Text(L10n.of(context).settings),
                            content: Column(
                              children: [
                                TextFormField(
                                  initialValue: match.maxScore.toString(),
                                  onChanged: (value) {
                                    match = match.copyWith(
                                      maxScore:
                                          int.tryParse(value) ?? match.maxScore,
                                    );
                                  },
                                  decoration: InputDecoration(
                                    labelText: L10n.of(
                                      context,
                                    ).pointsToWinLabel,
                                    floatingLabelBehavior: .always,
                                  ),
                                ),
                                SwitchListTile(
                                  value: match.halfScoreToEliminate,
                                  contentPadding: .zero,
                                  materialTapTargetSize: .shrinkWrap,
                                  title: Text(L10n.of(context).eliminateAtHalf),
                                  subtitle: Text(
                                    L10n.of(context).eliminateAtHalfDescription(
                                      (match.maxScore / 2).round(),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    match = match.copyWith(
                                      halfScoreToEliminate: value,
                                    );
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: Navigator.of(context).pop,
                                child: Text(L10n.of(context).ok),
                              ),
                            ],
                          );
                        },
                        child: const Icon(Icons.settings_rounded),
                      ),
                    ],
                    if (!match.isDetached) ...[
                      FloatingActionButton(
                        heroTag: 'swap',
                        onPressed: toggleSwap,
                        child: const Icon(Icons.swap_horiz_rounded),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        },
      ),
    );
  }
}
