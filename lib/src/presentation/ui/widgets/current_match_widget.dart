import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/presentation/ui/widgets/pulse_animation_widget.dart';

class CurrentMatchWidget extends StatelessWidget {
  const CurrentMatchWidget({super.key, required this.match, required this.onTap});

  final MatchEntity match;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: .transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Card(
          margin: .zero,
          child: Column(
            spacing: 8.0,
            crossAxisAlignment: .stretch,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 7,
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/volei-bg.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: Row(
                      spacing: 4.0,
                      children: [
                        Text(
                          L10n.of(context).matchNameTitle(match.name),
                          style: context.textTheme.titleMedium?.copyWith(fontWeight: .bold),
                        ),
                        const PulseAnimationWidget(runningColor: Colors.green),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 16.0,
                mainAxisAlignment: .center,
                children: [
                  Column(
                    spacing: 4.0,
                    crossAxisAlignment: .center,
                    children: [
                      Text(
                        match.firstTeam.name,
                        style: context.textTheme.titleMedium,
                      ),
                      Text(
                        '${match.firstTeamScore}',
                        style: context.textTheme.displayLarge?.copyWith(
                          fontWeight: .bold,
                          shadows: match.firstTeamScoreByOne
                              ? [
                                  const BoxShadow(
                                    color: Colors.yellow,
                                    spreadRadius: 8.0,
                                    blurRadius: 16.0,
                                    blurStyle: .outer,
                                  ),
                                ]
                              : [],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'vs',
                    style: context.textTheme.titleMedium,
                  ),
                  Column(
                    spacing: 4.0,
                    crossAxisAlignment: .center,
                    children: [
                      Text(
                        match.secondTeam.name,
                        style: context.textTheme.titleMedium,
                      ),
                      Text(
                        '${match.secondTeamScore}',
                        style: context.textTheme.displayLarge?.copyWith(
                          fontWeight: .bold,
                          shadows: match.secondTeamScoreByOne
                              ? [
                                  const BoxShadow(
                                    color: Colors.yellow,
                                    spreadRadius: 8.0,
                                    blurRadius: 16.0,
                                    blurStyle: .outer,
                                  ),
                                ]
                              : [],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
