import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'teams_view.dart';

class Teams extends StatefulWidget {
  final String eventId;

  const Teams({super.key, required this.eventId});

  static const String path = '/events/:eventId/teams';

  static const String name = 'teams';

  static Future<T?> push<T>(BuildContext context, String eventId) async {
    return context.pushNamed(name, pathParameters: {'eventId': eventId});
  }

  @override
  State<Teams> createState() => TeamsView();
}
