import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'match_history_view.dart';

class MatchHistory extends StatefulWidget {
  const MatchHistory({super.key, required this.eventId});

  final int eventId;

  static String get path => '/matche-history/:eventId';

  static const String name = 'match-history';

  static Future<T?> push<T>(
    BuildContext context,
    int eventId, {
    Object? arguments,
  }) async {
    return context.pushNamed(
      name,
      pathParameters: {
        'eventId': eventId.toString(),
      },
    );
  }

  @override
  State<MatchHistory> createState() => MatchHistoryView();
}
