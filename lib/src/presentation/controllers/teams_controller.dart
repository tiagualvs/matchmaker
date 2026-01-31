import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';

class TeamsController extends ChangeNotifier {
  TeamsController(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  void setState(void Function() fn) {
    fn();
    notifyListeners();
  }

  bool loading = true;

  List<TeamEntity> teams = [];

  Future<void> loadDependencies(
    int eventId, {
    void Function(String error)? onError,
  }) async {
    final result = await _teamsRepository.findMany(eventId);

    return result.fold(
      (teams) {
        this.teams = teams;

        loading = false;

        notifyListeners();
      },
      (error) {
        return onError?.call(error.toString());
      },
    );
  }

  Future<void> changePlayers(
    PlayerEntity firstPlayer,
    PlayerEntity secondPlayer, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
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

    notifyListeners();

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
        return onSuccess?.call();
      },
      (err) {
        teams = sourceTeams;

        notifyListeners();

        return onError?.call(err.toString());
      },
    );
  }

  void resetController() {
    teams = [];
    loading = true;
  }
}
