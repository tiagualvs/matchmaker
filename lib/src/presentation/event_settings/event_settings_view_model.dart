import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';

import 'event_settings.dart';

abstract class EventSettingsViewModel extends State<EventSettings> {
  final EventsRepository _eventsRepository = Injector.instance.get();
  final MatchesRepository _matchesRepository = Injector.instance.get();

  bool _loading = false;

  bool get loading => _loading;

  late EventEntity _event = widget.event;

  EventEntity get event => _event;

  set event(EventEntity event) => setState(() {
    _event = event;
  });

  Future<void> save({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
    });

    final result = await _eventsRepository.updateOne(
      event.id,
      UpdateOneEventParams(
        name: event.name,
        maxScore: event.maxScore,
        halfScoreToEliminate: event.halfScoreToEliminate,
        maxPlayerPerTeam: event.maxPlayerPerTeam,
        balancedByGender: event.balancedByGender,
        balancedByLevel: event.balancedByLevel,
        maxWinsInARow: event.maxWinsInARow,
      ),
    );

    return result.fold(
      (event) async {
        if (event.halfScoreToEliminate != event.halfScoreToEliminate) {
          final result1 = await _matchesRepository.updateManyByEventId(
            event.id,
            UpdateOneMatchParams(
              halfScoreToEliminate: event.halfScoreToEliminate,
            ),
          );

          if (result1.hasError) return onError?.call(result1.error.toString());
        }

        return onSuccess?.call();
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
