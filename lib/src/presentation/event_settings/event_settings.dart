import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'event_settings_view.dart';

class EventSettings extends StatefulWidget {
  const EventSettings({super.key, required this.event});

  final EventEntity event;

  static const String path = '/event-settings';

  static const String name = 'event-settings';

  static Future<T?> push<T>(
    BuildContext context,
    EventEntity event, {
    Object? arguments,
  }) {
    return context.pushNamed(name, extra: event);
  }

  @override
  State<EventSettings> createState() => EventSettingsView();
}
