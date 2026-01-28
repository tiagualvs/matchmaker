import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._eventsRepository);

  final EventsRepository _eventsRepository;

  bool _loading = false;

  bool get loading => _loading;

  List<EventEntity> _events = [];

  List<EventEntity> get events => _events;

  Future<void> getEventsList({
    void Function(String error)? onError,
  }) async {
    _loading = true;

    notifyListeners();

    final result = await _eventsRepository.findMany();

    return result.fold(
      (events) {
        _events = events;
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

  Future<void> newDay() async {}
}
