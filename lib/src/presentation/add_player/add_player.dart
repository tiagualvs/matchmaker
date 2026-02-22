import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'add_player_view.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({super.key, required this.event});

  final EventEntity event;

  static const String path = '/teams/add-player';

  static Future<T?> push<T>(BuildContext context, EventEntity event) async {
    return Navigator.of(context).pushNamed<T>(path, arguments: event);
  }

  @override
  State<AddPlayer> createState() => AddPlayerView();
}
