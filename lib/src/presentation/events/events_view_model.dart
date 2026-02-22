import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

import 'events.dart';

abstract class EventsViewModel extends State<Events> {
  late final EventsRepository _eventsRepository;

  bool _loading = true;

  bool get loading => _loading;

  List<EventEntity> _events = [];

  List<EventEntity> get events => _events;

  @override
  void initState() {
    super.initState();

    _eventsRepository = Injector.instance.get();

    WidgetsBinding.instance.addPostFrameCallback((_) => getEventsList());
  }

  Future<void> getEventsList({
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
    });

    final result = await _eventsRepository.findMany();

    return result.fold(
      (events) {
        return setState(() {
          _loading = false;
          _events = events;
        });
      },
      (error) {
        return setState(() {
          _loading = false;
          return onError?.call(error.toString());
        });
      },
    );
  }
}
