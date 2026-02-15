import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'teams_view.dart';

class Teams extends StatefulWidget {
  const Teams({super.key, required this.event});

  final EventEntity event;

  static const String path = '/teams';

  static const String name = 'teams';

  static Future<T?> push<T>(
    BuildContext context,
    EventEntity event,
  ) async {
    return context.pushNamed(name, extra: event);
  }

  @override
  State<Teams> createState() => TeamsView();
}
