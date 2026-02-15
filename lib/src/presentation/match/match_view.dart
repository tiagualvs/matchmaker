import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
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
                'Fim de partida',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: .bold,
                ),
              ),
              content: Text.rich(
                TextSpanBuilder.build(
                  'O time [b]${team.name}[/b] venceu a partia por [b]$score[/b]!\n\nConfirmar e ir para próxima partida?',
                  normalStyle: context.textTheme.bodyLarge,
                  boldStyle: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: .bold,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => context.pop(false),
                  style: TextButton.styleFrom(
                    foregroundColor: context.colorScheme.error,
                  ),
                  child: const Text('Não, reverter!'),
                ),
                TextButton(
                  onPressed: () => context.pop(true),
                  child: const Text('Sim, confirmar!'),
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
          child: FittedBox(
            child: Text(
              firstTeamScore.toString(),
              style: context.textTheme.displayLarge?.copyWith(
                fontWeight: .bold,
                color: switch (firstTeamByOneOrWon) {
                  true => Colors.yellow,
                  false => Colors.white,
                },
                // fontSize: 256.0,
              ),
            ),
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
          child: FittedBox(
            child: Text(
              secondTeamScore.toString(),
              style: context.textTheme.displayLarge?.copyWith(
                fontWeight: .bold,
                color: switch (secondTeamByOneOrWon) {
                  true => Colors.yellow,
                  false => Colors.white,
                },
              ),
            ),
          ),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (match.ended && match.isDetached) {
        final confirm = await Dialogs.show(
          context,
          title: 'Fim de partida',
          content: 'Deseja iniciar uma nova partida?',
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              style: TextButton.styleFrom(
                foregroundColor: context.colorScheme.error,
              ),
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () => context.pop(true),
              child: const Text('Sim'),
            ),
          ],
        );

        if (!context.mounted) return;

        if (confirm ?? false) return restartDetachedMatch();

        return context.pop();
      }

      if (match.ended) return context.pop();
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
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        swapped ? secondTeam.name : firstTeam.name,
                        textAlign: .center,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: .bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (match.isDetached) ...[
                      FloatingActionButton(
                        heroTag: 'settings',
                        onPressed: () async {
                          await Dialogs.display(
                            context,
                            constraints: const BoxConstraints(
                              minWidth: 480.0,
                            ),
                            title: const Text('Configurações'),
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
                                  decoration: const InputDecoration(
                                    labelText:
                                        'Quantitade de pontos para vencer',
                                    floatingLabelBehavior: .always,
                                  ),
                                ),
                                SwitchListTile(
                                  value: match.halfScoreToEliminate,
                                  contentPadding: .zero,
                                  materialTapTargetSize: .shrinkWrap,
                                  title: const Text('Eliminar na metade?'),
                                  subtitle: Text(
                                    'Elimina no ${(match.maxScore / 2).round()} x 0.',
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
                                onPressed: () => context.pop(),
                                child: const Text('Ok'),
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
                    Expanded(
                      child: Text(
                        swapped ? firstTeam.name : secondTeam.name,
                        textAlign: .center,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: .bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
