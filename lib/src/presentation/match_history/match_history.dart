import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'match_history_view.dart';

class MatchHistory extends StatefulWidget {
  const MatchHistory({super.key, required this.event});

  final EventEntity event;

  static const String path = '/match-history';

  static Future<T?> push<T>(BuildContext context, EventEntity event) async {
    return Navigator.of(context).pushNamed(path, arguments: event);
  }

  @override
  State<MatchHistory> createState() => MatchHistoryView();
}
