import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

class MatchHistoryController extends ChangeNotifier {
  final EventsRepository _eventRepository;

  MatchHistoryController(this._eventRepository);

  bool _loading = false;

  bool get loading => _loading;

  EventEntity _event = EventEntity.empty();

  EventEntity get event => _event;

  Future<void> loadDependencies(
    int eventId, {
    void Function(String error)? onError,
  }) async {
    _loading = true;

    notifyListeners();

    final result = await _eventRepository.findOne(eventId);

    return result.fold(
      (event) {
        _event = event;

        _loading = false;

        notifyListeners();
      },
      (error) {
        _loading = false;

        notifyListeners();

        return onError?.call(error.toString());
      },
    );
  }
}
