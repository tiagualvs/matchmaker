import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';

import 'add_player.dart';

abstract class AddPlayerViewModel extends State<AddPlayer> {
  final EventsRepository _eventsRepository = GetIt.instance.get();
  final TeamsRepository _teamsRepository = GetIt.instance.get();
  final PlayersRepository _playersRepository = GetIt.instance.get();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;

  EventEntity _event = EventEntity.empty();

  EventEntity get event => _event;

  set event(EventEntity event) => setState(() {
    _event = event;
  });

  TeamEntity _team = TeamEntity.empty('');

  TeamEntity get team => _team;

  set team(TeamEntity team) => setState(() {
    _team = team;
  });

  List<PlayerEntity> get players => _team.players;

  Future<void> loadDependencies({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final result = await _eventsRepository.findOne(event.id);

    return result.fold(
      (event) {
        return setState(() {
          _event = event;

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

    if (_event.hasPlayer(insertedPlayer.id)) {
      return setState(() {
        loading = false;

        return onError?.call('Jogador já cadastrado em outro time!');
      });
    }

    return setState(() {
      loading = false;

      _team = _team.copyWith(
        players: [
          insertedPlayer,
          ..._team.players,
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
          eventId: _event.id,
          name: _team.name,
          players: _team.players,
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
        _event.id,
        UpdateOneEventParams(
          queue: [..._event.queue, insertedTeam.id],
        ),
      );

      if (result1.hasError) {
        return setState(() {
          loading = false;

          return onError?.call(result1.error.toString());
        });
      }

      return setState(() {
        _team = insertedTeam;

        loading = false;

        return onSuccess?.call();
      });
    }
  }
}
