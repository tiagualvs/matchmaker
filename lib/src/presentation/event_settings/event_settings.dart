import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'event_settings_view.dart';

class EventSettings extends StatefulWidget {
  final String eventId;

  const EventSettings({super.key, required this.eventId});

  static const String path = '/events/:eventId/settings';

  static const String name = 'event-settings';

  static Future<T?> push<T>(BuildContext context, String eventId) {
    return context.pushNamed(name, pathParameters: {'eventId': eventId});
  }

  @override
  State<EventSettings> createState() => EventSettingsView();
}
