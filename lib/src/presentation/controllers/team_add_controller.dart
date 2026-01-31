import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';

class TeamAddController extends ChangeNotifier {
  TeamAddController(
    this._eventsRepository,
    this._teamsRepository,
    this._playersRepository,
  );

  void setState(void Function() fn) {
    fn();
    return notifyListeners();
  }

  final EventsRepository _eventsRepository;

  final TeamsRepository _teamsRepository;

  final PlayersRepository _playersRepository;

  bool loading = false;

  bool adding = false;

  String playerName = '';

  Set<PlayerGender> playerGender = {};

  EventEntity event = EventEntity.empty();

  TeamEntity team = TeamEntity.empty('');

  Future<void> loadDependencies(
    int eventId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final result = await _eventsRepository.findOne(eventId);

    return result.fold(
      (event) {
        this.event = event;

        loading = false;

        notifyListeners();

        return onSuccess?.call();
      },
      (error) {
        return onError?.call(error.toString());
      },
    );
  }

  Future<void> addPlayer({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final result = await _playersRepository.insertOne(
      InsertOnePlayerParams(
        name: playerName,
        gender: playerGender.first.value,
        level: PlayerLevel.basic.value,
      ),
    );

    if (result.hasError) return onError?.call(result.error.toString());

    final player = result.value;

    if (event.hasPlayer(player.id)) {
      return onError?.call('Jogador já cadastrado em outro time!');
    }

    team = team.copyWith(
      players: [
        player,
        ...team.players,
      ],
    );

    adding = false;

    playerName = '';

    playerGender.clear();

    notifyListeners();

    return onSuccess?.call();
  }

  Future<void> save({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    loading = true;

    notifyListeners();

    final result0 = await _teamsRepository.insertOne(
      InsertOneTeamParams(
        eventId: event.id,
        name: team.name,
        players: team.players,
      ),
    );

    return result0.fold(
      (team) async {
        final result1 = await _eventsRepository.updateOne(
          event.id,
          UpdateOneEventParams(
            queue: [...event.queue, team.id],
          ),
        );

        if (result1.hasError) return onError?.call(result1.error.toString());

        this.team = team;

        loading = false;

        notifyListeners();

        return onSuccess?.call();
      },
      (error) {
        return onError?.call(error.toString());
      },
    );
  }

  void resetController() {
    event = EventEntity.empty();
    team = TeamEntity.empty('');
    playerName = '';
    playerGender.clear();
    adding = false;
    loading = true;
  }
}
