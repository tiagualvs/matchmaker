import 'package:flutter/material.dart';

import 'events_view.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  static const String path = '/';

  static const String name = 'events';

  @override
  State<Events> createState() => EventsView();
}
