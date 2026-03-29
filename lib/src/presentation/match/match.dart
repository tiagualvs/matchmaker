import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/shared/id.dart';

import 'match_view.dart';

class Match extends StatefulWidget {
  final String eventId;

  final String matchId;

  const Match({super.key, required this.eventId, required this.matchId});

  static const String path = '/events/:eventId/match/:matchId';

  static const String name = 'match';

  static Future<T?> push<T>(
    BuildContext context,
    String eventId,
    String matchId,
  ) {
    return context.pushNamed(
      name,
      pathParameters: {'eventId': eventId, 'matchId': matchId},
    );
  }

  static Future<T?> detached<T>(BuildContext context) {
    return context.pushNamed(
      name,
      pathParameters: {'eventId': Id.max(), 'matchId': Id.max()},
    );
  }

  @override
  State<Match> createState() => MatchView();
}
