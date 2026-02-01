import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/dialogs.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/others/text_span_builder.dart';
import 'package:matchmaker/src/common/shared/controller.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/match_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key, required this.matchId, required this.controller});

  final int matchId;
  final MatchController controller;

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> with ControllerMixin {
  MatchController get controller => widget.controller;

  bool get loading => controller.loading;

  bool get swapped => controller.swapped;

  MatchEntity get match => controller.match;

  TeamEntity get firstTeam => match.firstTeam;

  int get firstTeamScore => match.firstTeamScore;

  bool get firstTeamByOneOrWon => match.firstTeamScoreByOne || match.firstTeamWon;

  TeamEntity get secondTeam => match.secondTeam;

  int get secondTeamScore => match.secondTeamScore;

  bool get secondTeamByOneOrWon => match.secondTeamScoreByOne || match.secondTeamWon;

  @override
  Controller get bind => controller;

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
                style: context.textTheme.headlineMedium?.copyWith(fontWeight: .bold),
              ),
              content: Text.rich(
                TextSpanBuilder.build(
                  'O time [b]${team.name}[/b] venceu a partia por [b]$score[/b]!\n\nConfirmar e ir para próxima partida?',
                  normalStyle: context.textTheme.bodyLarge,
                  boldStyle: context.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => context.pop(false),
                  style: TextButton.styleFrom(foregroundColor: context.colorScheme.error),
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await WakelockPlus.enable();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);

      return controller.loadDependencies(widget.matchId, onError: SnackBars.error);
    });
  }

  @override
  void dispose() {
    scheduleMicrotask(() async {
      await WakelockPlus.disable();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      controller.resetController();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstTeamWidget = Expanded(
      child: GestureDetector(
        onTap: () => controller.incrementScore(
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
            return controller.reverseScore(
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
        onTap: () => controller.incrementScore(
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
            return controller.reverseScore(
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

        if (confirm ?? false) {
          return controller.restartDetachedMatch();
        }

        return context.pop();
      }

      if (match.ended) {
        return context.pop();
      }
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
                            constraints: const BoxConstraints(minWidth: 480.0),
                            title: const Text('Configurações'),
                            content: ListenableBuilder(
                              listenable: controller,
                              builder: (context, child) {
                                return Column(
                                  children: [
                                    TextFormField(
                                      initialValue: controller.match.maxScore.toString(),
                                      onChanged: (value) => controller.setState(() {
                                        controller.match = controller.match.copyWith(
                                          maxScore: int.tryParse(value) ?? controller.match.maxScore,
                                        );
                                      }),
                                      decoration: const InputDecoration(
                                        labelText: 'Quantitade de pontos para vencer',
                                        floatingLabelBehavior: .always,
                                      ),
                                    ),
                                    SwitchListTile(
                                      value: controller.match.halfScoreToEliminate,
                                      contentPadding: .zero,
                                      materialTapTargetSize: .shrinkWrap,
                                      title: const Text('Eliminar na metade?'),
                                      subtitle: Text(
                                        'Elimina no ${(controller.match.maxScore / 2).round()} x 0.',
                                      ),
                                      onChanged: (value) => controller.setState(() {
                                        controller.match = controller.match.copyWith(
                                          halfScoreToEliminate: value,
                                        );
                                      }),
                                    ),
                                  ],
                                );
                              },
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
                        onPressed: controller.toggleSwap,
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
