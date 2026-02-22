import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'teams_view.dart';

class Teams extends StatefulWidget {
  const Teams({super.key, required this.event});

  final EventEntity event;

  static const String path = '/teams';

  static Future<T?> push<T>(BuildContext context, EventEntity event) async {
    return Navigator.of(context).pushNamed(path, arguments: event);
  }

  @override
  State<Teams> createState() => TeamsView();
}
