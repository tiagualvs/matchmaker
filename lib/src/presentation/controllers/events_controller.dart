import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

class EventsController extends ChangeNotifier {
  EventsController(this._eventsRepository);

  final EventsRepository _eventsRepository;

  void setState([void Function()? func]) {
    func?.call();
    return notifyListeners();
  }

  bool _loading = true;

  bool get loading => _loading;

  List<EventEntity> _events = [];

  List<EventEntity> get events => _events;

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

  void resetController() {
    _events = [];
    _loading = true;
  }
}
