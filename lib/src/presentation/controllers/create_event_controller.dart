import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';

const teamNames = <String>[
  'Aperreados',
  'Arrochados',
  'Bonequeiros',
  'Cabras da Peste',
  'Cangaceiros',
  'Desmantelados',
  'Esfomeados',
  'Fuleragens',
  'Fubangas',
  'Gaiatos',
  'Marmotas',
  'Miseráveis',
  'Ruma de Doido',
  'Aí Dento 🫳',
];

class CreateEventController extends ChangeNotifier {
  CreateEventController(this._eventsRepository, this._playersRepository);

  final EventsRepository _eventsRepository;

  final PlayersRepository _playersRepository;

  bool _loading = false;

  bool get loading => _loading;

  EventEntity _event = EventEntity.empty().copyWith(
    name: 'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
  );

  EventEntity get event => _event;

  List<PlayerEntity> _players = [];

  List<PlayerEntity> get players => _players;

  int get numTeams => (_players.length / _event.maxPlayerPerTeam).ceil();

  final TextEditingController importerController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  Set<PlayerGender> _selectedGender = {};

  Set<PlayerGender> get selectedGender => _selectedGender;

  Timer? _timer;

  void handleEventChanges(EventEntity event) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      _event = event;
      notifyListeners();
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
      return onError?.call('Não é possível gerar eventos com menos de 2 times!');
    }

    final randomTeamNames = List<String>.from(teamNames)..shuffle();

    final teams = randomTeamNames.take(numTeams).map(TeamEntity.empty).toList();

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
        final jokerGender = womenCount <= menCount ? PlayerGender.female : PlayerGender.male;

        teams[i] = teams[i].copyWith(
          players: [
            ...teams[i].players,
            PlayerEntity.joker(jokerIndex + 1, jokerGender),
          ],
        );

        jokerIndex++;
      }
    }

    _event = _event.copyWith(teams: teams);

    notifyListeners();

    return onSuccess?.call();
  }

  Future<void> handleSaveEvent({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    _loading = true;

    notifyListeners();

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
        _loading = false;

        notifyListeners();

        return onError?.call(error.toString());
      },
    );
  }

  void handleGenderChange(Set<PlayerGender> genders) {
    _selectedGender = genders;
    notifyListeners();
  }

  Future<void> handleAddPlayer({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final result = await _playersRepository.insertOne(
      InsertOnePlayerParams(
        name: nameController.text,
        gender: selectedGender.first.value,
        level: PlayerLevel.basic.value,
      ),
    );

    if (result.isError) return onError?.call(result.failure.toString());

    players.add(result.value);

    nameController.clear();

    selectedGender.clear();

    notifyListeners();
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

    if (result.isError) return onError?.call(result.failure.toString());

    players[index] = result.value;

    notifyListeners();
  }

  void handleRemovePlayer(int index) {
    players.removeAt(index);
    notifyListeners();
  }

  Future<void> importFromRawList({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final regex = RegExp(r'^(\d+)(\s+)-(\s+)(.+)');

    final names =
        importerController.text
            .split('\n')
            .where((line) => line.isNotEmpty)
            .where(regex.hasMatch)
            .map((line) => line.split(' - ').skip(1).join(' - ').trim())
            .map(removeEmojis)
            .toList()
          ..sort((a, b) => a.compareTo(b));

    if (names.isEmpty) {
      importerController.clear();

      return onError?.call('Nenhum jogador encontrado na lista colada!');
    }

    for (final name in names) {
      final result0 = await _playersRepository.findOneByName(name);

      if (result0.isOk) {
        players.add(result0.value);
      } else {
        final match = RegExp(r'(.+)\s+-\s+(H|h|M|m)').firstMatch(name);

        if (match == null) {
          final result1 = await _playersRepository.insertOne(
            InsertOnePlayerParams(
              name: name,
              gender: PlayerGender.unknown.value,
              level: PlayerLevel.basic.value,
            ),
          );

          if (result1.isError) return onError?.call(result1.failure.toString());

          players.add(result1.value);
        } else {
          final playerName = match.group(1)!;
          final playerGender = match.group(2)!;

          final result1 = await _playersRepository.insertOne(
            InsertOnePlayerParams(
              name: playerName,
              gender: playerGender.toLowerCase() == 'm' ? PlayerGender.female.value : PlayerGender.male.value,
              level: PlayerLevel.basic.value,
            ),
          );

          if (result1.isError) return onError?.call(result1.failure.toString());

          players.add(result1.value);
        }
      }
    }

    _players = players.toSet().toList();

    players.sort((a, b) => a.name.compareTo(b.name));

    importerController.clear();

    notifyListeners();

    return onSuccess?.call();
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

  void resetController() {
    importerController.clear();
    nameController.clear();
    selectedGender.clear();
    _players.clear();
    _event = EventEntity.empty().copyWith(
      name: 'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
    );
    _loading = false;
  }
}
