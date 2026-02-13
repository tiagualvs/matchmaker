import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'create_event_view.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  static const String path = '/create-event';

  static const String name = 'create-event';

  static Future<T?> push<T>(BuildContext context) {
    return context.pushNamed(name);
  }

  @override
  State<CreateEvent> createState() => CreateEventView();
}
