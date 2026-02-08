import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

class MatchHistoryController extends ChangeNotifier {
  MatchHistoryController(this._eventRepository);

  void setState([void Function()? func]) {
    func?.call();
    return notifyListeners();
  }

  final EventsRepository _eventRepository;

  bool _loading = true;

  bool get loading => _loading;

  EventEntity _event = EventEntity.empty();

  EventEntity get event => _event;

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

  void resetController() {
    _loading = true;
    _event = EventEntity.empty();
  }
}
