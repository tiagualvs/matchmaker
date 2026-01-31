import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

class MatchHistoryController extends ChangeNotifier {
  MatchHistoryController(this._eventRepository);

  void setState(void Function() func) {
    func();
    notifyListeners();
  }

  final EventsRepository _eventRepository;

  bool loading = false;

  EventEntity event = EventEntity.empty();

  Future<void> loadDependencies(
    int eventId, {
    void Function(String error)? onError,
  }) async {
    setState(() {
      loading = true;
    });

    final result = await _eventRepository.findOne(eventId);

    return result.fold(
      (event) {
        return setState(() {
          this.event = event;

          loading = false;
        });
      },
      (error) {
        return setState(() {
          loading = false;

          return onError?.call(error.toString());
        });
      },
    );
  }
}
