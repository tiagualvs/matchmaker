import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

import 'event_settings_view.dart';

class EventSettings extends StatefulWidget {
  const EventSettings({super.key, required this.event});

  final EventEntity event;

  static const String path = '/event-settings';

  static Future<T?> push<T>(BuildContext context, EventEntity event) {
    return Navigator.of(context).pushNamed(path, arguments: event);
  }

  @override
  State<EventSettings> createState() => EventSettingsView();
}
