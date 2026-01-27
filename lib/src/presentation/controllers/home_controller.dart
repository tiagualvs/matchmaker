import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._eventsRepository);

  final EventsRepository _eventsRepository;

  List<EventEntity> _events = [];

  List<EventEntity> get events => _events;

  Future<void> getEventsList() async {
    final result = await _eventsRepository.findMany();

    return result.fold(
      (events) {
        _events = events;
        notifyListeners();
      },
      (error) {
        print(error);
      },
    );
  }

  Future<void> newDay() async {}
}
