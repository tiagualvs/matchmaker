import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'teams_view.dart';

class Teams extends StatefulWidget {
  const Teams({super.key, required this.eventId});

  final int eventId;

  static const String path = '/teams/:eventId';

  static const String name = 'teams';

  static Future<T?> push<T>(BuildContext context, int eventId) async {
    return context.pushNamed(
      name,
      pathParameters: {
        'eventId': eventId.toString(),
      },
    );
  }

  @override
  State<Teams> createState() => TeamsView();
}
