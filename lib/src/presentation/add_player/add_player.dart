import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'add_player_view.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({super.key, required this.event});

  final EventEntity event;

  static const String path = '/teams/add-player';

  static const String name = 'add-player';

  static Future<T?> push<T>(
    BuildContext context,
    EventEntity event,
  ) async {
    return context.pushNamed(name, extra: event);
  }

  @override
  State<AddPlayer> createState() => AddPlayerView();
}
