import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/common/extensions/string_ext.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';

import 'create_event.dart';

abstract class CreateEventViewModel extends State<CreateEvent> {
  late final EventsRepository _eventsRepository;
  late final PlayersRepository _playersRepository;

  @override
  void initState() {
    super.initState();

    _eventsRepository = GetIt.instance.get();
    _playersRepository = GetIt.instance.get();
  }

  bool _loading = false;

  bool get loading => _loading;

  EventEntity _event = EventEntity.empty().copyWith(
    name: 'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
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
      return onError?.call(
        'Para gerar o evento balanceado por gênero, todos os jogadores devem ter um gênero definido!',
      );
    }

    if (numTeams < 2) {
      return onError?.call(
        'Não é possível gerar eventos com menos de 2 times!',
      );
    }

    final randomTeamNames = List<String>.from(TeamEntity.names)..shuffle();

    final teams = randomTeamNames.take(numTeams).map(TeamEntity.empty).toList();

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
      return onError?.call(
        'O evento precisa de pelo menos 3 times para ser gerado!',
      );
    }

    setState(() => _loading = true);

    final result = await _eventsRepository.insertOne(
      InsertOneEventParams(
        name: _event.name,
        maxScore: _event.maxScore,
        halfScoreToEliminate: _event.halfScoreToEliminate,
        maxPlayerPerTeam: _event.maxPlayerPerTeam,
        balancedByGender: _event.balancedByGender,
        balancedByLevel: _event.balancedByLevel,
        maxWinsInARow: _event.maxWinsInARow,
        teams: _event.teams,
      ),
    );

    return result.fold(
      (event) {
        return onSuccess?.call();
      },
      (error) {
        return setState(() {
          _loading = false;

          return onError?.call(error.toString());
        });
      },
    );
  }

  Future<void> handleAddPlayer(
    PlayerEntity player, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final result = await _playersRepository.insertOne(
      InsertOnePlayerParams(
        name: player.name,
        gender: player.gender.value,
        level: player.level.value,
      ),
    );

    if (result.hasError) return onError?.call(result.error.toString());

    final insertedPlayer = result.value;

    return setState(() {
      _players = [insertedPlayer, ..._players]
        ..sort((a, b) => a.name.compareTo(b.name));
    });
  }

  Future<void> handlePlayerChanges(
    int index,
    PlayerEntity player, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (player.id.isNegative) {
      return onError?.call('Jogador inválido!');
    }

    final result = await _playersRepository.updateOne(
      player.id,
      UpdateOnePlayerParams(
        name: player.name,
        gender: player.gender.value,
        level: player.level.value,
      ),
    );

    if (result.hasError) return onError?.call(result.error.toString());

    return setState(() {
      _players[index] = result.value;
    });
  }

  void handleRemovePlayer(int index) =>
      setState(() => _players.removeAt(index));

  Future<void> importFromRawList(
    String list, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final regex = RegExp(r'(.+)-(.+)');

    final names =
        list
            .split('\n')
            .where((line) => line.isNotEmpty)
            .where(regex.hasMatch)
            .map(
              (line) => line
                  .split('-')
                  .skip(1)
                  .map((part) => part.trim())
                  .join('-')
                  .trim(),
            )
            .where((line) => line.isNotEmpty)
            .map(removeEmojis)
            .toList()
          ..sort((a, b) => a.compareTo(b));

    if (names.isEmpty) {
      setState(() {
        return onError?.call('Nenhum jogador encontrado na lista colada!');
      });
    }

    for (final name in names) {
      final match = RegExp(r'(.+)-(h|H|m|M)').firstMatch(name);

      if (match == null) {
        final result = await _playersRepository.findOneByName(
          name.toCapitalCase(),
        );

        if (result.hasValue) {
          _players.add(result.value);
        } else {
          final result1 = await _playersRepository.insertOne(
            InsertOnePlayerParams(
              name: name.toCapitalCase(),
              gender: PlayerGender.unknown.value,
              level: PlayerLevel.basic.value,
            ),
          );

          if (result1.hasError) return onError?.call(result1.error.toString());

          _players.add(result1.value);
        }
      } else {
        final playerName = match.group(1)!.trim().toCapitalCase();
        final playerGender = match.group(2)!.trim();

        final result = await _playersRepository.findOneByName(playerName);

        if (result.hasValue) {
          _players.add(result.value);
        } else {
          final result1 = await _playersRepository.insertOne(
            InsertOnePlayerParams(
              name: playerName,
              gender: PlayerGender.fromValue(playerGender).value,
              level: PlayerLevel.basic.value,
            ),
          );

          if (result1.hasError) return onError?.call(result1.error.toString());

          _players.add(result1.value);
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
