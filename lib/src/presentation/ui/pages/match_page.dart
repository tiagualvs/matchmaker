import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/match_controller.dart';

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
                'Partida encerrada?',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: .bold,
                ),
              ),
              content: Text(
                'O time ${team.name} está prestes a vencer a partida por $score!\n\nConfirma o ultimo ponto para encerrar a partida?',
                style: context.textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => context.pop(false),
                  child: const Text('Não'),
                ),
                TextButton(
                  onPressed: () => context.pop(true),
                  child: const Text('Sim'),
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
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      return controller.loadDependencies(widget.matchId);
    });
  }

  @override
  void dispose() {
    controller.resetController();
    scheduleMicrotask(
      () async => await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
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

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (match.ended) {
            final team = match.firstTeamWon ? firstTeam : secondTeam;
            final max = math.max(match.firstTeamScore, match.secondTeamScore);
            final min = math.min(match.firstTeamScore, match.secondTeamScore);

            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Partida encerrada!'),
                  content: Text(
                    'O time ${team.name} venceu por $max x $min!',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );

            if (!context.mounted) return;

            return context.pop();
          }
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
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      Text(
                        swapped ? secondTeam.name : firstTeam.name,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: .bold,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: toggleSwap,
                        child: const Icon(Icons.swap_horiz_rounded),
                      ),
                      Text(
                        swapped ? firstTeam.name : secondTeam.name,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: .bold,
                          color: Colors.white,
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
