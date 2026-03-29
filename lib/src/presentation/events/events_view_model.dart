import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

import 'events.dart';

abstract class EventsViewModel extends State<Events> {
  SharedPreferencesService get prefs => Injector.instance.get();

  bool _loading = true;

  bool get loading => _loading;

  List<EventEntity> _events = [];

  List<EventEntity> get events => _events;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => getEventsList());
  }

  Future<void> getEventsList({
    void Function(String error)? onError,
  }) async {
    setState(() => _loading = true);

    final events = prefs.findMany<EventEntity>()
      ..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );

    return setState(() {
      _loading = false;
      _events = events;
    });
  }
}
