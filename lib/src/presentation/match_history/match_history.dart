import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'match_history_view.dart';

class MatchHistory extends StatefulWidget {
  const MatchHistory({super.key, required this.event});

  final EventEntity event;

  static String get path => '/matche-history';

  static const String name = 'match-history';

  static Future<T?> push<T>(BuildContext context, EventEntity event) async {
    return context.pushNamed(name, extra: event);
  }

  @override
  State<MatchHistory> createState() => MatchHistoryView();
}
