import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class EventController extends ChangeNotifier {
  EventController(
    this._eventsRepository,
    this._playersRepository,
    this._teamsRepository,
    this._matchesRepository,
  );

  final EventsRepository _eventsRepository;

  final PlayersRepository _playersRepository;

  final TeamsRepository _teamsRepository;

  final MatchesRepository _matchesRepository;

  bool _loading = false;

  bool get loading => _loading;

  bool _sharing = false;

  bool get sharing => _sharing;

  EventEntity _event = EventEntity.empty();

  EventEntity get event => _event;

  void _startLoading() {
    _loading = true;

    notifyListeners();
  }

  void _stopLoading() {
    _loading = false;

    notifyListeners();
  }

  Future<void> loadDependencies(
    int eventId, {
    required Future<void> Function(
      TeamEntity winner,
      TeamEntity firstTeam,
      TeamEntity secondTeam,
    )
    onMaxWinsInARow,
    required Future<void> Function(TeamEntity team) onNeedsJoker,
    void Function(String error)? onError,
  }) async {
    _loading = true;

    _sharing = false;

    notifyListeners();

    final result0 = await _eventsRepository.findOne(eventId);

    return result0.fold(
      (event) async {
        final currentMatch = event.currentMatch;
        final lastEndedMatch = event.lastEndedMatch;
        if (!event.ended && currentMatch == null && lastEndedMatch != null) {
          final winner = lastEndedMatch.firstTeamWon ? lastEndedMatch.firstTeam : lastEndedMatch.secondTeam;
          final loser = lastEndedMatch.firstTeamWon ? lastEndedMatch.secondTeam : lastEndedMatch.firstTeam;
          if (event.teamHasMaxWinsInARow(winner.id)) {
            final nextIds = event.queue.take(2).toList();

            await onMaxWinsInARow(
              winner,
              event.teams.firstWhere((team) => team.id == nextIds.first),
              event.teams.firstWhere((team) => team.id == nextIds.last),
            );

            final queue = [winner.id, ...event.queue.skip(2), loser.id];

            final result1 = await _matchesRepository.insertOne(
              InsertOneMatchParams(
                eventId: eventId,
                name: 'Partida #${event.matches.length + 1}',
                firstTeamId: nextIds.first,
                secondTeamId: nextIds.last,
                maxScore: event.maxScore,
                halfScoreToEliminate: event.halfScoreToEliminate,
                queue: queue,
              ),
            );

            result1.fold(
              (match) {
                _event = event.copyWith(
                  matches: [
                    ...event.matches,
                    match.copyWith(
                      firstTeam: event.teams.firstWhere(
                        (team) => team.id == nextIds.first,
                      ),
                      secondTeam: event.teams.firstWhere(
                        (team) => team.id == nextIds.last,
                      ),
                    ),
                  ],
                  queue: queue,
                );
              },
              (error) {
                return onError?.call(error.toString());
              },
            );
          } else {
            final nextId = event.queue.first;

            final queue = [...event.queue.skip(1), loser.id];

            final firstTeam = lastEndedMatch.firstTeam.id == winner.id
                ? winner
                : event.teams.firstWhere((team) => team.id == nextId);
            final secondTeam = lastEndedMatch.secondTeam.id == winner.id
                ? winner
                : event.teams.firstWhere((team) => team.id == nextId);

            if (firstTeam.players.length != _event.maxPlayerPerTeam) {
              await onNeedsJoker(firstTeam);
            }

            if (secondTeam.players.length != _event.maxPlayerPerTeam) {
              await onNeedsJoker(secondTeam);
            }

            final result1 = await _matchesRepository.insertOne(
              InsertOneMatchParams(
                eventId: eventId,
                name: 'Partida #${event.matches.length + 1}',
                firstTeamId: firstTeam.id,
                secondTeamId: secondTeam.id,
                maxScore: event.maxScore,
                halfScoreToEliminate: event.halfScoreToEliminate,
                queue: queue,
              ),
            );

            result1.fold(
              (match) {
                _event = event.copyWith(
                  matches: [
                    ...event.matches,
                    match.copyWith(
                      firstTeam: firstTeam,
                      secondTeam: secondTeam,
                    ),
                  ],
                  queue: queue,
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

    final result0 = await _eventsRepository.updateOne(
      _event.id,
      const UpdateOneEventParams(ended: true),
    );

    return result0.fold(
      (event) async {
        for (final match in _event.notEndedMatches) {
          final result1 = await _matchesRepository.deleteOne(match.id);

          if (result1.hasError) return onError?.call(result1.error.toString());
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

  Future<void> shareEvent(
    WidgetsToImageController controller, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    _sharing = true;

    notifyListeners();

    final bytes = await controller.capturePng(
      waitForAnimations: true,
      delayMs: 100,
    );

    if (bytes == null) {
      return onError?.call('Erro ao compartilhar evento!');
    }

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            bytes,
            name: '${_event.name}.png',
            mimeType: 'image/png',
          ),
        ],
      ),
    );

    _sharing = false;

    notifyListeners();

    return onSuccess?.call();
  }

  Future<void> insertPlayer(
    String name,
    PlayerGender gender,
    PlayerLevel level, {
    void Function(PlayerEntity player)? onSuccess,
    void Function(String error)? onError,
  }) async {
    final result = await _playersRepository.insertOne(
      InsertOnePlayerParams(
        name: name,
        gender: gender.value,
        level: level.value,
      ),
    );

    return result.fold(
      (value) => onSuccess?.call(value),
      (error) => onError?.call(error.toString()),
    );
  }

  Future<void> addPlayer(
    String name,
    PlayerGender gender, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (!_event.hasIncompleteTeams) {
      return onError?.call('O evento já possui times completos!');
    }

    _startLoading();

    final currentTeam = _event.teams.firstWhere((team) => team.players.length != _event.maxPlayerPerTeam);

    final result0 = await _playersRepository.insertOne(
      InsertOnePlayerParams(
        name: name,
        gender: gender.value,
        level: PlayerLevel.basic.value,
      ),
    );

    if (result0.hasError) {
      _stopLoading();

      return onError?.call(result0.error.toString());
    }

    if (_event.teams.any((t) => t.id != currentTeam.id && t.players.any((p) => p.id == result0.value.id))) {
      _stopLoading();

      return onError?.call('O jogador já está cadastrado no evento em outro time!');
    }

    final result1 = await _teamsRepository.insertPlayer(currentTeam.id, result0.value.id);

    if (result1.hasError) {
      _stopLoading();

      return onError?.call(result1.error.toString());
    }

    _event = _event.copyWith(
      teams: _event.teams.map((t) {
        if (t.id == currentTeam.id) {
          return t.copyWith(
            players: [...t.players, result0.value],
          );
        }
        return t;
      }).toList(),
    );

    _stopLoading();

    return onSuccess?.call();
  }

  Future<void> addTeam(
    TeamEntity team, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    _startLoading();

    final result0 = await _teamsRepository.insertOne(
      InsertOneTeamParams(
        name: team.name,
        eventId: _event.id,
        players: team.players,
      ),
    );

    if (result0.hasError) {
      _stopLoading();

      return onError?.call(result0.error.toString());
    }

    final result1 = await _eventsRepository.updateOne(
      _event.id,
      UpdateOneEventParams(
        queue: [..._event.queue, result0.value.id],
      ),
    );

    if (result1.hasError) return onError?.call(result1.error.toString());

    _event = result1.value;

    _stopLoading();

    return onSuccess?.call();
  }
}
