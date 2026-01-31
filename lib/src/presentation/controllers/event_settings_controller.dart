import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';

class EventSettingsController extends ChangeNotifier {
  EventSettingsController(this._eventsRepository, this._matchesRepository);

  void setState(void Function() func) {
    func();
    notifyListeners();
  }

  final EventsRepository _eventsRepository;

  final MatchesRepository _matchesRepository;

  bool loading = false;

  EventEntity event = EventEntity.empty();

  Future<void> loadDependencies(
    int eventId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() {
      loading = true;
    });

    final result = await _eventsRepository.findOne(eventId);

    return result.fold(
      (event) {
        return setState(() {
          this.event = event;

          loading = false;

          return onSuccess?.call();
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

  Future<void> save({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() {
      loading = true;
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
            UpdateOneMatchParams(halfScoreToEliminate: event.halfScoreToEliminate),
          );

          if (result1.hasError) return onError?.call(result1.error.toString());
        }

        return onSuccess?.call();
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
    loading = true;
    event = EventEntity.empty();
  }
}
