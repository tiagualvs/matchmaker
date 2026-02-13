import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'events_settings_view.dart';

class EventSettings extends StatefulWidget {
  const EventSettings({super.key, required this.eventId});

  final int eventId;

  static const String path = '/event-settings/:eventId';

  static const String name = 'event-settings';

  static Future<T?> push<T>(
    BuildContext context,
    int eventId, {
    Object? arguments,
  }) {
    return context.pushNamed(
      name,
      pathParameters: {
        'eventId': eventId.toString(),
      },
    );
  }

  @override
  State<EventSettings> createState() => EventsSettingsView();
}
