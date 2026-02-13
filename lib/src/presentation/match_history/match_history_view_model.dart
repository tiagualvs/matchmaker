import 'package:flutter/material.dart';
import 'package:matchmaker/main.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

import 'match_history.dart';

abstract class MatchHistoryViewModel extends State<MatchHistory> {
  late final EventsRepository _eventRepository;

  @override
  void initState() {
    super.initState();

    _eventRepository = Injector.instance.get<EventsRepository>();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => loadDependencies(widget.eventId),
    );
  }

  bool _loading = true;

  bool get loading => _loading;

  EventEntity _event = EventEntity.empty();

  EventEntity get event => _event;

  List<MatchEntity> get matches => _event.endedMatches;

  Future<void> loadDependencies(
    int eventId, {
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
    });

    final result = await _eventRepository.findOne(eventId);

    return result.fold(
      (event) {
        return setState(() {
          _event = event;

          _loading = false;
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
