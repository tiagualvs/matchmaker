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

  void setState([void Function()? func]) {
    func?.call();
    return notifyListeners();
  }

  final EventsRepository _eventsRepository;

  final TeamsRepository _teamsRepository;

  final PlayersRepository _playersRepository;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;

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

  Future<void> handleInsertPlayer(
    PlayerEntity player, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() {
      loading = true;
    });

    final result = await _playersRepository.insertOne(
      InsertOnePlayerParams(
        name: player.name,
        gender: player.gender.value,
        level: player.level.value,
      ),
    );

    if (result.hasError) {
      return setState(() {
        loading = false;

        return onError?.call(result.error.toString());
      });
    }

    final insertedPlayer = result.value;

    if (event.hasPlayer(insertedPlayer.id)) {
      return setState(() {
        loading = false;

        return onError?.call('Jogador já cadastrado em outro time!');
      });
    }

    return setState(() {
      loading = false;

      team = team.copyWith(
        players: [
          insertedPlayer,
          ...team.players,
        ],
      );

      return onSuccess?.call();
    });
  }

  Future<void> save({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => loading = true);

      final result0 = await _teamsRepository.insertOne(
        InsertOneTeamParams(
          eventId: event.id,
          name: team.name,
          players: team.players,
        ),
      );

      if (result0.hasError) {
        return setState(() {
          loading = false;

          return onError?.call(result0.error.toString());
        });
      }

      final insertedTeam = result0.value;

      final result1 = await _eventsRepository.updateOne(
        event.id,
        UpdateOneEventParams(
          queue: [...event.queue, insertedTeam.id],
        ),
      );

      if (result1.hasError) {
        return setState(() {
          loading = false;

          return onError?.call(result1.error.toString());
        });
      }

      return setState(() {
        team = insertedTeam;

        loading = false;

        return onSuccess?.call();
      });
    }
  }

  void resetController() {
    event = EventEntity.empty();
    team = TeamEntity.empty('');
    loading = true;
  }
}
