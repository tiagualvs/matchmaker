import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/others/text_span_builder.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/match_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({
    super.key,
    required this.matchId,
    required this.controller,
  });

  final int matchId;
  final MatchController controller;

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  MatchController get controller => widget.controller;

  MatchEntity get match => controller.match;

  TeamEntity get firstTeam => match.firstTeam;

  TeamEntity get secondTeam => match.secondTeam;

  bool swapped = false;

  void toggleSwap() {
    setState(() {
      swapped = !swapped;
    });
  }

  Future<bool> confirmEndOfMatch({
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
      return controller.loadDependencies(widget.matchId);
    });
  }

  @override
  void dispose() {
    scheduleMicrotask(
      () async {
        await WakelockPlus.disable();

        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        controller.resetController();
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (match.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (match.ended) return context.pop();
        });

        final firstTeamWidget = Expanded(
          child: GestureDetector(
            onTap: () => controller.incrementScore(
              firstTeam.id,
              confirmEndOfMatch: () => confirmEndOfMatch(
                team: firstTeam,
                score: '${match.firstTeamScore} x ${match.secondTeamScore}',
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
                  match.firstTeamScore.toString(),
                  style: context.textTheme.displayLarge?.copyWith(
                    fontWeight: .bold,
                    color: switch (match.firstTeamScoreByOne || match.firstTeamWon) {
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
              confirmEndOfMatch: () => confirmEndOfMatch(
                team: secondTeam,
                score: '${match.secondTeamScore} x ${match.firstTeamScore}',
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
                  match.secondTeamScore.toString(),
                  style: context.textTheme.displayLarge?.copyWith(
                    fontWeight: .bold,
                    color: switch (match.secondTeamScoreByOne || match.secondTeamWon) {
                      true => Colors.yellow,
                      false => Colors.white,
                    },
                  ),
                ),
              ),
            ),
          ),
        );

        return SafeArea(
          child: Scaffold(
            body: Stack(
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
                      FloatingActionButton(
                        onPressed: toggleSwap,
                        child: const Icon(Icons.swap_horiz_rounded),
                      ),
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
          ),
        );
      },
    );
  }
}
