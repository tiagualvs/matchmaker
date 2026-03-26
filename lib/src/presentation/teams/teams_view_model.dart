import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';

import 'teams.dart';

abstract class TeamsViewModel extends State<Teams> {
  late final L10n l10n = L10n.of(context);

  final EventsRepository _eventsRepository = Injector.instance.get();
  final PlayersRepository _playersRepository = Injector.instance.get();
  final TeamsRepository _teamsRepository = Injector.instance.get();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => teamsNormalizer());
  }

  bool loading = false;

  late EventEntity _event = widget.event;

  EventEntity get event => _event;

  List<TeamEntity> _teams = [];

  List<TeamEntity> get teams => _teams;

  void teamsNormalizer([TeamEntity? team]) {
    setState(() {
      if (team != null) {
        _event = _event.copyWith(teams: [..._event.teams, team]);
      }

      _teams = [];

      if (_event.hasIncompleteTeams) {
        for (final team in _event.teams) {
          final diff = _event.maxPlayerPerTeam - team.players.length;

          if (diff > 0) {
            _teams.add(
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
            _teams.add(team);
          }
        }
      } else {
        _teams = List.from(event.teams);
      }
    });
  }

  Future<void> changePlayers(
    PlayerEntity firstPlayer,
    PlayerEntity secondPlayer, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (firstPlayer.isJoker || secondPlayer.isJoker) return;

    final sourceTeams = List<TeamEntity>.from(_teams);

    final firstTeam = sourceTeams.firstWhere(
      (team) => team.players.contains(firstPlayer),
    );

    final secondTeam = sourceTeams.firstWhere(
      (team) => team.players.contains(secondPlayer),
    );

    if (firstTeam.id == secondTeam.id) return;

    final firstTeamIndex = sourceTeams.indexOf(firstTeam);

    final firstPlayerIndex = firstTeam.players.indexOf(firstPlayer);

    final secondTeamIndex = sourceTeams.indexOf(secondTeam);

    final secondPlayerIndex = secondTeam.players.indexOf(secondPlayer);

    sourceTeams[firstTeamIndex] = firstTeam.copyWith(
      players: List.from(firstTeam.players)..[firstPlayerIndex] = secondPlayer,
    );

    sourceTeams[secondTeamIndex] = secondTeam.copyWith(
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

    if (result.hasError) {
      return setState(() {
        return onError?.call(result.error.toString());
      });
    }

    return setState(() {
      _teams = sourceTeams;

      return onSuccess?.call();
    });
  }

  Future<void> deleteTeam(
    int teamId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() => loading = true);

    if (event.teams.length == 3) {
      setState(() => loading = false);
      return onError?.call(l10n.minTeamsWarning);
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
      return onError?.call(l10n.playerAlreadyInTeamError);
    }

    final result1 = await _teamsRepository.insertPlayer(
      teamId,
      insertedPlayer.id,
    );

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
}
