import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'match_history_view.dart';

class MatchHistory extends StatefulWidget {
  final String eventId;

  const MatchHistory({super.key, required this.eventId});

  static const String path = '/events/:eventId/match-history';

  static const String name = 'match-history';

  static Future<T?> push<T>(BuildContext context, String eventId) async {
    return context.pushNamed(name, pathParameters: {'eventId': eventId});
  }

  @override
  State<MatchHistory> createState() => MatchHistoryView();
}
