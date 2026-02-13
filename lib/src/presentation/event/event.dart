import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'event_view.dart';

class Event extends StatefulWidget {
  const Event({super.key, required this.eventId});

  final int eventId;

  static const String path = '/events/:eventId';

  static const String name = 'event';

  static Future<T?> push<T>(
    BuildContext context,
    int eventId,
  ) {
    return context.pushNamed(
      name,
      pathParameters: {
        'eventId': eventId.toString(),
      },
    );
  }

  @override
  State<Event> createState() => EventView();
}
