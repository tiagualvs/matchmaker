import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/repositories/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches_repository.dart';

class EventController extends ChangeNotifier {
  EventController(this._eventsRepository, this._matchesRepository);

  final EventsRepository _eventsRepository;

  final MatchesRepository _matchesRepository;

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

    final result0 = await _eventsRepository.findOne(eventId);

    return result0.fold(
      (event) async {
        if (event.currentMatch != null && event.currentMatch?.ended == true) {
          final currentMatch = event.currentMatch!;
          final winner = currentMatch.firstTeamWon ? currentMatch.firstTeam : currentMatch.secondTeam;
          final loser = currentMatch.firstTeamWon ? currentMatch.secondTeam : currentMatch.firstTeam;
          final result1 = await _matchesRepository.insertOne(
            InsertOneMatchParams(
              eventId: eventId,
              name: 'Partida #${event.matches.length + 1}',
              firstTeamId: winner.id,
              secondTeamId: event.queue.first,
              maxScore: event.maxScore,
              enqueue: loser.id,
              dequeue: event.queue.first,
            ),
          );

          result1.fold(
            (match) {
              _event = event.copyWith(
                matches: [
                  ...event.matches,
                  match.copyWith(
                    firstTeam: winner,
                    secondTeam: event.teams.firstWhere((team) => team.id == event.queue.first),
                  ),
                ]..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
                queue: [...event.queue.skip(1), loser.id],
              );
            },
            (error) {
              return onError?.call(error.toString());
            },
          );
        } else {
          _event = event;
        }

        print('matches ${_event.matches.length}');

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
