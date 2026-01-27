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

        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16.0,
                mainAxisSize: .max,
                crossAxisAlignment: .stretch,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        match.name,
                        style: context.textTheme.headlineMedium,
                      ),
                      Text(
                        'Termina em ${match.maxScore}',
                        style: context.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Expanded(
                    child: IntrinsicHeight(
                      child: Row(
                        spacing: 16.0,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.incrementScore(
                                firstTeam.id,

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
                                child: Center(
                                  child: Text(
                                    match.firstTeamScore.toString(),
                                    style: context.textTheme.displayLarge?.copyWith(
                                      fontWeight: .bold,
                                      color: switch (match.firstTeamScore == match.maxScore - 1) {
                                        true => Colors.yellow,
                                        false => Colors.white,
                                      },
                                      fontSize: 256.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'vs',
                            style: context.textTheme.headlineLarge,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.incrementScore(
                                secondTeam.id,
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
                                child: Center(
                                  child: Text(
                                    match.secondTeamScore.toString(),
                                    style: context.textTheme.displayLarge?.copyWith(
                                      fontWeight: .bold,
                                      color: switch (match.secondTeamScore == match.maxScore - 1) {
                                        true => Colors.yellow,
                                        false => Colors.white,
                                      },
                                      fontSize: 256.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
