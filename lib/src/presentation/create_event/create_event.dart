import 'package:flutter/material.dart';

import 'create_event_view.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  static const String path = '/create-event';

  static Future<T?> push<T>(BuildContext context) {
    return Navigator.of(context).pushNamed(path);
  }

  @override
  State<CreateEvent> createState() => CreateEventView();
}
