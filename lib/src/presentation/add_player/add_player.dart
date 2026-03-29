import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'add_player_view.dart';

class AddPlayer extends StatefulWidget {
  final String eventId;

  const AddPlayer({super.key, required this.eventId});

  static const String path = '/events/:eventId/teams/add-player';

  static const String name = 'add-player';

  static Future<T?> push<T>(BuildContext context, String eventId) async {
    return context.pushNamed(name, pathParameters: {'eventId': eventId});
  }

  @override
  State<AddPlayer> createState() => AddPlayerView();
}
