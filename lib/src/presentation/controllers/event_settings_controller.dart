import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';

class EventSettingsController extends ChangeNotifier {
  final EventsRepository _eventsRepository;
  final MatchesRepository _matchesRepository;

  EventSettingsController(this._eventsRepository, this._matchesRepository);

  bool _loading = false;

  bool get loading => _loading;

  EventEntity _event = EventEntity.empty();

  EventEntity get event => _event;

  void handleEventChanges(EventEntity event) {
    _event = event;

    log(
      'Event name: ${_event.name}, maxScore: ${_event.maxScore}, halfScoreToEliminate: ${_event.halfScoreToEliminate}, maxPlayerPerTeam: ${_event.maxPlayerPerTeam}, balancedByGender: ${_event.balancedByGender}, balancedByLevel: ${_event.balancedByLevel}, maxWinsInARow: ${_event.maxWinsInARow}',
    );

    notifyListeners();
  }

  Future<void> loadDependencies(
    int eventId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    _loading = true;

    notifyListeners();

    final result = await _eventsRepository.findOne(eventId);

    return result.fold(
      (event) {
        _event = event;

        _loading = false;

        notifyListeners();

        return onSuccess?.call();
      },
      (error) {
        _loading = false;

        notifyListeners();

        return onError?.call(error.toString());
      },
    );
  }

  Future<void> save({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    _loading = true;

    notifyListeners();

    final result = await _eventsRepository.updateOne(
      _event.id,
      UpdateOneEventParams(
        name: _event.name,
        maxScore: _event.maxScore,
        halfScoreToEliminate: _event.halfScoreToEliminate,
        maxPlayerPerTeam: _event.maxPlayerPerTeam,
        balancedByGender: _event.balancedByGender,
        balancedByLevel: _event.balancedByLevel,
        maxWinsInARow: _event.maxWinsInARow,
      ),
    );

    return result.fold(
      (event) async {
        if (event.halfScoreToEliminate != _event.halfScoreToEliminate) {
          final result1 = await _matchesRepository.updateManyByEventId(
            event.id,
            UpdateOneMatchParams(halfScoreToEliminate: event.halfScoreToEliminate),
          );

          if (result1.hasError) return onError?.call(result1.error.toString());
        }

        return onSuccess?.call();
      },
      (error) {
        _loading = false;

        notifyListeners();

        return onError?.call(error.toString());
      },
    );
  }

  void resetController() {
    _loading = true;
    _event = EventEntity.empty();
  }
}
