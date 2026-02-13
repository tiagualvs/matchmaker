import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'add_player_view.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({super.key, required this.eventId});

  final int eventId;

  static const String path = '/teams/:eventId/add-player';

  static const String name = 'addPlayer';

  static Future<T?> push<T>(BuildContext context, int eventId) async {
    return context.pushNamed(
      name,
      pathParameters: {
        'eventId': eventId.toString(),
      },
    );
  }

  @override
  State<AddPlayer> createState() => AddPlayerView();
}
