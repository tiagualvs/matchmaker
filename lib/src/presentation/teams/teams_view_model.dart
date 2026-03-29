import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

import 'teams.dart';

abstract class TeamsViewModel extends State<Teams> {
  L10n get l10n => L10n.of(context);

  SharedPreferencesService get prefs => Injector.instance.get();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => teamsNormalizer());
  }

  bool loading = false;

  late EventEntity _event =
      prefs.find<EventEntity>((e) => e.id == widget.eventId) ??
      EventEntity.empty();

  EventEntity get event => _event;

  late List<TeamEntity> _teams = _event.teams;

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
      updatedAt: Timestamp.now(),
    );

    sourceTeams[secondTeamIndex] = secondTeam.copyWith(
      players: List.from(secondTeam.players)..[secondPlayerIndex] = firstPlayer,
      updatedAt: Timestamp.now(),
    );

    _event = _event.copyWith(teams: sourceTeams, updatedAt: Timestamp.now());

    final saved = await prefs.put<EventEntity>(_event);

    if (!saved) return onError?.call(l10n.failedToSaveEventError);

    return setState(() {
      _teams = sourceTeams;

      return onSuccess?.call();
    });
  }

  Future<void> deleteTeam(
    String teamId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() => loading = true);

    if (event.teams.length == 3) {
      setState(() => loading = false);
      return onError?.call(l10n.minTeamsWarning);
    }

    _teams.removeWhere((team) => team.id == teamId);

    _event = _event.copyWith(teams: _teams, updatedAt: Timestamp.now());

    final saved = await prefs.put<EventEntity>(_event);

    if (!saved) return onError?.call(l10n.failedToSaveEventError);

    return setState(() {
      loading = false;

      _teams = _teams.where((team) => team.id != teamId).toList();

      return onSuccess?.call();
    });
  }

  Future<void> insertPlayer(
    int index,
    String teamId,
    PlayerEntity player, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() => loading = true);

    final teamIndex = _teams.indexWhere((team) => team.id == teamId);

    if (teamIndex == -1) return;

    if (_teams[teamIndex].players.length == _event.maxPlayerPerTeam) {
      setState(() => loading = false);
      return onError?.call(l10n.maxPlayersPerTeamError);
    }

    _teams[teamIndex] = _teams[teamIndex].copyWith(
      players: List.from(_teams[teamIndex].players)..[index] = player,
      updatedAt: Timestamp.now(),
    );

    _event = _event.copyWith(teams: _teams, updatedAt: Timestamp.now());

    final saved = await prefs.put<EventEntity>(_event);

    if (!saved) return onError?.call(l10n.failedToSaveEventError);

    return setState(() {
      loading = false;

      return onSuccess?.call();
    });
  }
}
