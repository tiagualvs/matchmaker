import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';

import 'match_view.dart';

class Match extends StatefulWidget {
  const Match({super.key, required this.match});

  final MatchEntity? match;

  static const String path = '/match';

  static const String name = 'match';

  static Future<T?> push<T>(BuildContext context, [MatchEntity? match]) {
    return context.pushNamed(name, extra: match);
  }

  @override
  State<Match> createState() => MatchView();
}
