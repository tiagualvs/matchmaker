import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

class EventsController extends ChangeNotifier {
  EventsController(this._eventsRepository);

  void setState(void Function() func) {
    func();
    notifyListeners();
  }

  final EventsRepository _eventsRepository;

  bool loading = true;

  List<EventEntity> events = [];

  Future<void> getEventsList({
    void Function(String error)? onError,
  }) async {
    setState(() {
      loading = true;
    });

    final result = await _eventsRepository.findMany();

    return result.fold(
      (events) {
        return setState(() {
          loading = false;
          this.events = events;
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

  void resetController() {
    events = [];
    loading = true;
  }
}
