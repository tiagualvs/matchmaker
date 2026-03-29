import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/string_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

import 'create_event.dart';

abstract class CreateEventViewModel extends State<CreateEvent> {
  L10n get l10n => L10n.of(context);

  SharedPreferencesService get prefs => Injector.instance.get();

  bool _loading = false;

  bool get loading => _loading;

  late EventEntity _event = EventEntity.create(
    name: l10n.defaultEventName(Timestamp.now()),
  );

  EventEntity get event => _event;

  List<TeamEntity> get teams => _event.teams;

  List<PlayerEntity> _players = [];

  List<PlayerEntity> get players => _players;

  int get numTeams => (_players.length / _event.maxPlayerPerTeam).ceil();

  Timer? _timer;

  void handleEventChanges(EventEntity event) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() => _event = event);
    });
  }

  void handleGenerateTeams({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) {
    if (_event.balancedByGender && _players.any((player) => player.isUnknown)) {
      return onError?.call(l10n.balanceByGenderError);
    }

    if (numTeams < 2) {
      return onError?.call(l10n.minTeamsError);
    }

    final randomTeamNames = List<String>.from(TeamEntity.names)..shuffle();

    final teams = randomTeamNames.take(numTeams).map(
      (name) {
        return TeamEntity.create(
          eventId: _event.id,
          name: name,
          players: [],
        );
      },
    ).toList();

    _players.shuffle();

    // Calculate how many teams we can fully fill
    final fullTeamsCount = (_players.length / _event.maxPlayerPerTeam).floor();
    final targetTeamsCount = fullTeamsCount;

    // Prepare player lists based on balancing flags
    List<PlayerEntity> women = [];
    List<PlayerEntity> men = [];
    List<PlayerEntity> allPlayers = [];

    if (_event.balancedByGender) {
      // Separate players by gender
      women = _players.where((player) => player.isWoman).toList();
      men = _players.where((player) => player.isMan).toList();

      // Sort by level if balancedByLevel is true
      if (_event.balancedByLevel) {
        final levelOrder = {
          PlayerLevel.advanced: 2,
          PlayerLevel.intermediate: 1,
          PlayerLevel.basic: 0,
        };

        women.sort((a, b) {
          return (levelOrder[b.level] ?? 0).compareTo(levelOrder[a.level] ?? 0);
        });

        men.sort((a, b) {
          return (levelOrder[b.level] ?? 0).compareTo(levelOrder[a.level] ?? 0);
        });
      } else {
        // Shuffle if not balancing by level
        women.shuffle();
        men.shuffle();
      }
    } else {
      // Don't separate by gender
      allPlayers = List<PlayerEntity>.from(_players);

      // Sort by level if balancedByLevel is true, otherwise shuffle
      if (_event.balancedByLevel) {
        final levelOrder = {
          PlayerLevel.advanced: 2,
          PlayerLevel.intermediate: 1,
          PlayerLevel.basic: 0,
        };

        allPlayers.sort((a, b) {
          return (levelOrder[b.level] ?? 0).compareTo(levelOrder[a.level] ?? 0);
        });
      } else {
        allPlayers.shuffle();
      }
    }

    var teamIndex = 0;

    if (_event.balancedByGender) {
      // Distribute women in round-robin fashion
      for (final woman in women) {
        bool placed = false;

        if (targetTeamsCount > 0) {
          for (int i = 0; i < targetTeamsCount; i++) {
            if (teams[teamIndex].players.length < _event.maxPlayerPerTeam) {
              teams[teamIndex] = teams[teamIndex].copyWith(
                players: [...teams[teamIndex].players, woman],
              );
              teamIndex = (teamIndex + 1) % targetTeamsCount;
              placed = true;
              break;
            }
            teamIndex = (teamIndex + 1) % targetTeamsCount;
          }
        }

        // If full or no target teams, put in the remainder team (last one)
        if (!placed && numTeams > targetTeamsCount) {
          final remainderIndex = numTeams - 1;
          teams[remainderIndex] = teams[remainderIndex].copyWith(
            players: [...teams[remainderIndex].players, woman],
          );
        }
      }

      // Distribute men in round-robin fashion
      teamIndex = 0;
      for (final man in men) {
        bool placed = false;

        if (targetTeamsCount > 0) {
          for (int i = 0; i < targetTeamsCount; i++) {
            if (teams[teamIndex].players.length < _event.maxPlayerPerTeam) {
              teams[teamIndex] = teams[teamIndex].copyWith(
                players: [...teams[teamIndex].players, man],
              );
              teamIndex = (teamIndex + 1) % targetTeamsCount;
              placed = true;
              break;
            }
            teamIndex = (teamIndex + 1) % targetTeamsCount;
          }
        }

        if (!placed && numTeams > targetTeamsCount) {
          final remainderIndex = numTeams - 1;
          teams[remainderIndex] = teams[remainderIndex].copyWith(
            players: [...teams[remainderIndex].players, man],
          );
        }
      }
    } else {
      // Distribute all players without gender separation
      for (final player in allPlayers) {
        bool placed = false;

        if (targetTeamsCount > 0) {
          for (int i = 0; i < targetTeamsCount; i++) {
            if (teams[teamIndex].players.length < _event.maxPlayerPerTeam) {
              teams[teamIndex] = teams[teamIndex].copyWith(
                players: [...teams[teamIndex].players, player],
              );
              teamIndex = (teamIndex + 1) % targetTeamsCount;
              placed = true;
              break;
            }
            teamIndex = (teamIndex + 1) % targetTeamsCount;
          }
        }

        if (!placed && numTeams > targetTeamsCount) {
          final remainderIndex = numTeams - 1;
          teams[remainderIndex] = teams[remainderIndex].copyWith(
            players: [...teams[remainderIndex].players, player],
          );
        }
      }
    }

    // Fill remaining spots with joker players, maintaining gender balance
    int jokerIndex = 0;
    for (var i = 0; i < teams.length; i++) {
      while (teams[i].players.length < _event.maxPlayerPerTeam) {
        final womenCount = teams[i].players.where((p) => p.isWoman).length;
        final menCount = teams[i].players.where((p) => p.isMan).length;
        final jokerGender = switch (_event.balancedByGender) {
          true =>
            womenCount <= menCount ? PlayerGender.female : PlayerGender.male,
          false => PlayerGender.unknown,
        };

        teams[i] = teams[i].copyWith(
          players: [
            ...teams[i].players,
            PlayerEntity.joker(jokerIndex + 1, jokerGender),
          ],
        );

        jokerIndex++;
      }
    }

    return setState(() {
      _event = _event.copyWith(teams: teams);

      return onSuccess?.call();
    });
  }

  Future<void> handleSaveEvent({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (_event.teams.length <= 2) {
      return onError?.call(l10n.minTeamsSaveError);
    }

    setState(() => _loading = true);

    final nextMatch = event.nextMatch();

    if (nextMatch != null) {
      final (match, queue) = nextMatch;

      _event = _event.copyWith(
        matches: [match],
        queue: queue,
      );
    }

    final saved = await prefs.put<EventEntity>(_event);

    if (!saved) return onError?.call(l10n.failedToSaveEventError);

    setState(() => _loading = false);

    return onSuccess?.call();
  }

  Future<void> handleAddPlayer(
    PlayerEntity player, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (player.isNotEmpty && !player.isJoker) {
      await prefs.put<PlayerEntity>(player);
    }

    return setState(() {
      _players = [player, ..._players]
        ..sort((a, b) => a.name.compareTo(b.name));
    });
  }

  Future<void> handlePlayerChanges(
    int index,
    PlayerEntity player, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (player.isEmpty || player.isJoker) {
      return onError?.call(l10n.invalidPlayerError);
    }

    final saved = await prefs.put<PlayerEntity>(player);

    if (!saved) return onError?.call(l10n.failedToSavePlayerError);

    return setState(() {
      _players[index] = player;
    });
  }

  void handleRemovePlayer(int index) =>
      setState(() => _players.removeAt(index));

  Future<void> importFromRawList(
    String list, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final prefixRegex = RegExp(r'^\s*\d+[\s.\-)]+');

    final names =
        list
            .split('\n')
            .where((line) => line.isNotEmpty)
            .map((line) => line.trim())
            .where((line) => prefixRegex.hasMatch(line))
            .map((line) => line.replaceFirst(prefixRegex, '').trim())
            .where((name) => name.isNotEmpty)
            .map(removeEmojis)
            .toList()
          ..sort((a, b) => a.compareTo(b));

    if (names.isEmpty) {
      setState(() {
        return onError?.call(l10n.noPlayersInListError);
      });
    }

    for (final name in names) {
      final match = RegExp(r'(.+)-(h|H|m|M)').firstMatch(name);

      if (match == null) {
        final foundPlayer = prefs.find<PlayerEntity>(
          (e) => e.name == name.toCapitalCase(),
        );

        if (foundPlayer != null) {
          _players.add(foundPlayer);
        } else {
          final newPlayer = PlayerEntity.create(
            name: name.toCapitalCase(),
            gender: PlayerGender.unknown,
            level: PlayerLevel.basic,
          );

          final saved = await prefs.put<PlayerEntity>(newPlayer);

          if (!saved) return onError?.call(l10n.failedToSavePlayerError);

          _players.add(newPlayer);
        }
      } else {
        final playerName = match.group(1)!.trim().toCapitalCase();
        final playerGender = match.group(2)!.trim();

        final foundPlayer = prefs.find<PlayerEntity>(
          (e) => e.name == playerName,
        );

        if (foundPlayer != null) {
          _players.add(foundPlayer);
        } else {
          final newPlayer = PlayerEntity.create(
            name: playerName,
            gender: PlayerGender.fromValue(playerGender),
            level: PlayerLevel.basic,
          );

          final saved = await prefs.put<PlayerEntity>(newPlayer);

          if (!saved) return onError?.call(l10n.failedToSavePlayerError);

          _players.add(newPlayer);
        }
      }
    }

    return setState(() {
      _players = _players.toSet().toList();

      _players.sort((a, b) => a.name.compareTo(b.name));

      return onSuccess?.call();
    });
  }

  String removeEmojis(String text) {
    final emojiRegex = RegExp(
      r'[\u{1F300}-\u{1F5FF}'
      r'\u{1F600}-\u{1F64F}'
      r'\u{1F680}-\u{1F6FF}'
      r'\u{1F700}-\u{1F77F}'
      r'\u{1F780}-\u{1F7FF}'
      r'\u{1F800}-\u{1F8FF}'
      r'\u{1F900}-\u{1F9FF}'
      r'\u{1FA00}-\u{1FAFF}'
      r'\u{2600}-\u{26FF}'
      r'\u{2700}-\u{27BF}]',
      unicode: true,
    );

    return text.replaceAll(emojiRegex, '').trim();
  }
}
