import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'event_view.dart';

class Event extends StatefulWidget {
  const Event({super.key, required this.event});

  final EventEntity event;

  static const String path = '/event';

  static const String name = 'event';

  static Future<T?> push<T>(
    BuildContext context,
    EventEntity event,
  ) {
    return context.pushNamed(name, extra: event);
  }

  @override
  State<Event> createState() => EventView();
}
