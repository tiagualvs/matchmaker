import 'dart:async';

import 'package:matchmaker/src/common/shared/controller.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';

class TeamsController extends Controller {
  TeamsController(this._eventsRepository, this._playersRepository, this._teamsRepository);

  final EventsRepository _eventsRepository;

  final PlayersRepository _playersRepository;

  final TeamsRepository _teamsRepository;

  bool loading = true;

  EventEntity _event = EventEntity.empty();

  EventEntity get event => _event;

  List<TeamEntity> _teams = [];

  List<TeamEntity> get teams => _teams;

  Future<void> loadDependencies(
    int eventId, {
    void Function(String error)? onError,
  }) async {
    setState(() {
      loading = true;
    });

    final result = await _eventsRepository.findOne(eventId);

    return result.fold(
      (event) {
        return setState(() {
          _event = event;
          _teams = [];

          if (event.hasIncompleteTeams) {
            for (final team in event.teams) {
              final diff = event.maxPlayerPerTeam - team.players.length;

              if (diff > 0) {
                teams.add(
                  team.copyWith(
                    players: [
                      ...team.players,
                      ...List.generate(
                        diff,
                        (index) => PlayerEntity.joker(
                          index,
                          PlayerGender.unknown,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                teams.add(team);
              }
            }
          } else {
            _teams = List.from(event.teams);
          }

          loading = false;
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

  Future<void> changePlayers(
    PlayerEntity firstPlayer,
    PlayerEntity secondPlayer, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (firstPlayer.isJoker || secondPlayer.isJoker) return;

    final sourceTeams = teams;

    final firstTeam = teams.firstWhere((team) => team.players.contains(firstPlayer));

    final secondTeam = teams.firstWhere((team) => team.players.contains(secondPlayer));

    if (firstTeam.id == secondTeam.id) return;

    final firstTeamIndex = teams.indexOf(firstTeam);

    final firstPlayerIndex = firstTeam.players.indexOf(firstPlayer);

    final secondTeamIndex = teams.indexOf(secondTeam);

    final secondPlayerIndex = secondTeam.players.indexOf(secondPlayer);

    teams[firstTeamIndex] = firstTeam.copyWith(
      players: List.from(firstTeam.players)..[firstPlayerIndex] = secondPlayer,
    );

    teams[secondTeamIndex] = secondTeam.copyWith(
      players: List.from(secondTeam.players)..[secondPlayerIndex] = firstPlayer,
    );

    final result = await _teamsRepository.swapPlayers(
      SwapPlayersParams(
        firstTeamId: firstTeam.id,
        secondTeamId: secondTeam.id,
        firstPlayerId: firstPlayer.id,
        secondPlayerId: secondPlayer.id,
      ),
    );

    return result.fold(
      (_) {
        setState();
        return onSuccess?.call();
      },
      (err) {
        _teams = sourceTeams;

        return onError?.call(err.toString());
      },
    );
  }

  Future<void> deleteTeam(
    int teamId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() => loading = true);

    if (event.teams.length == 3) {
      setState(() => loading = false);
      return onError?.call('O evento chegou a quantidade mínima de times!');
    }

    final result0 = await _teamsRepository.deleteOne(teamId);

    if (result0.hasError) {
      setState(() => loading = false);
      return onError?.call(result0.error.toString());
    }

    final result1 = await _eventsRepository.updateOne(
      event.id,
      UpdateOneEventParams(
        queue: List.from(event.queue)..removeWhere((id) => id == teamId),
      ),
    );

    if (result1.hasError) {
      setState(() => loading = false);
      return onError?.call(result1.error.toString());
    }

    return setState(() {
      loading = false;

      _teams = _teams.where((team) => team.id != teamId).toList();

      return onSuccess?.call();
    });
  }

  Future<void> insertPlayer(
    int index,
    int teamId,
    PlayerEntity player, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() => loading = true);

    final result0 = await _playersRepository.insertOne(
      InsertOnePlayerParams(
        name: player.name,
        gender: player.gender.value,
        level: player.level.value,
      ),
    );

    if (result0.hasError) {
      setState(() => loading = false);
      return onError?.call(result0.error.toString());
    }

    final insertedPlayer = result0.value;

    if (event.hasPlayer(insertedPlayer.id)) {
      setState(() => loading = false);
      return onError?.call('Jogador já cadastrado em outro time!');
    }

    final result1 = await _teamsRepository.insertPlayer(teamId, insertedPlayer.id);

    if (result1.hasError) {
      setState(() => loading = false);
      return onError?.call(result1.error.toString());
    }

    final teamIndex = teams.indexWhere((team) => team.id == teamId);

    if (teamIndex == -1) return;

    teams[teamIndex] = teams[teamIndex].copyWith(
      players: [...teams[teamIndex].players]..[index] = insertedPlayer,
    );

    return setState(() {
      loading = false;

      _event = event.copyWith(teams: teams);

      onSuccess?.call();
    });
  }

  void resetController() {
    _event = EventEntity.empty();
    _teams = [];
    loading = true;
  }
}
