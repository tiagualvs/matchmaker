import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'match_view.dart';

class Match extends StatefulWidget {
  const Match({super.key, required this.matchId});

  final int matchId;

  static const String path = '/match/:matchId';

  static const String name = 'match';

  static Future<T?> push<T>(BuildContext context, int matchId) {
    return context.pushNamed(
      name,
      pathParameters: {
        'matchId': matchId.toString(),
      },
    );
  }

  @override
  State<Match> createState() => MatchView();
}
