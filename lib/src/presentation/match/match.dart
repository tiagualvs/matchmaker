import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';

import 'match_view.dart';

class Match extends StatefulWidget {
  const Match({super.key, required this.match});

  final MatchEntity? match;

  static const String path = '/match';

  static Future<T?> push<T>(BuildContext context, [MatchEntity? match]) {
    return Navigator.of(context).pushNamed(path, arguments: match);
  }

  @override
  State<Match> createState() => MatchView();
}
