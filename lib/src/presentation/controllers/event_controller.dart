import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';

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
    required Future<void> Function(
      TeamEntity winner,
      TeamEntity firstTeam,
      TeamEntity secondTeam,
    )
    onMaxWinsInARow,
    void Function(String error)? onError,
  }) async {
    _loading = true;

    notifyListeners();

    final result0 = await _eventsRepository.findOne(eventId);

    return result0.fold(
      (event) async {
        if (!event.ended && event.currentMatch == null && event.lastEndedMatch != null) {
          final lastEndedMatch = event.lastEndedMatch!;
          final winner = lastEndedMatch.firstTeamWon ? lastEndedMatch.firstTeam : lastEndedMatch.secondTeam;
          final loser = lastEndedMatch.firstTeamWon ? lastEndedMatch.secondTeam : lastEndedMatch.firstTeam;
          if (event.teamHasMaxWinsInARow(winner.id)) {
            final nextIds = event.queue.take(2).toList();

            await onMaxWinsInARow(
              winner,
              event.teams.firstWhere((team) => team.id == nextIds.first),
              event.teams.firstWhere((team) => team.id == nextIds.last),
            );

            final result1 = await _matchesRepository.insertOne(
              InsertOneMatchParams(
                eventId: eventId,
                name: 'Partida #${event.matches.length + 1}',
                firstTeamId: nextIds.first,
                secondTeamId: nextIds.last,
                maxScore: event.maxScore,
                halfScoreToEliminate: event.halfScoreToEliminate,
                enqueue: [winner.id, loser.id],
                dequeue: nextIds,
              ),
            );
            result1.fold(
              (match) {
                _event = event.copyWith(
                  matches: [
                    ...event.matches,
                    match.copyWith(
                      firstTeam: event.teams.firstWhere((team) => team.id == nextIds.first),
                      secondTeam: event.teams.firstWhere((team) => team.id == nextIds.last),
                    ),
                  ],
                  queue: [winner.id, ...event.queue.skip(2), loser.id],
                );
              },
              (error) {
                return onError?.call(error.toString());
              },
            );
          } else {
            final nextId = event.queue.first;

            final firstTeam = lastEndedMatch.firstTeam.id == winner.id
                ? winner
                : event.teams.firstWhere((team) => team.id == nextId);
            final secondTeam = lastEndedMatch.secondTeam.id == winner.id
                ? winner
                : event.teams.firstWhere((team) => team.id == nextId);

            final result1 = await _matchesRepository.insertOne(
              InsertOneMatchParams(
                eventId: eventId,
                name: 'Partida #${event.matches.length + 1}',
                firstTeamId: firstTeam.id,
                secondTeamId: secondTeam.id,
                maxScore: event.maxScore,
                halfScoreToEliminate: event.halfScoreToEliminate,
                enqueue: [loser.id],
                dequeue: [nextId],
              ),
            );

            result1.fold(
              (match) {
                _event = event.copyWith(
                  matches: [
                    ...event.matches,
                    match.copyWith(firstTeam: firstTeam, secondTeam: secondTeam),
                  ],
                  queue: [...event.queue.skip(1), loser.id],
                );
              },
              (error) {
                return onError?.call(error.toString());
              },
            );
          }
        } else {
          _event = event;
        }

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

  Future<void> endEvent({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    _loading = true;

    notifyListeners();

    if (_event.endedMatches.isEmpty) {
      final result0 = await _eventsRepository.deleteOne(_event.id);

      return result0.fold(
        (_) async {
          return onSuccess?.call();
        },
        (error) {
          _loading = false;

          notifyListeners();

          return onError?.call(error.toString());
        },
      );
    }

    final result0 = await _eventsRepository.updateOne(_event.id, const UpdateOneEventParams(ended: true));

    return result0.fold(
      (event) async {
        for (final match in _event.notEndedMatches) {
          final result1 = await _matchesRepository.deleteOne(match.id);

          if (result1.isError) return onError?.call(result1.failure.toString());
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
}
