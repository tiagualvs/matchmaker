import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

import 'match_history.dart';

abstract class MatchHistoryViewModel extends State<MatchHistory> {
  final EventsRepository _eventRepository = Injector.instance.get();

  bool _loading = false;

  bool get loading => _loading;

  late EventEntity _event = widget.event;

  EventEntity get event => _event;

  List<MatchEntity> get matches => _event.endedMatches;

  Future<void> loadDependencies({
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
    });

    final result = await _eventRepository.findOne(_event.id);

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
