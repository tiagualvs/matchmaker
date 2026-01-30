import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

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
  CreateEventController(this._repository);

  final EventsRepository _repository;

  bool _loading = false;

  bool get loading => _loading;

  EventEntity _event = EventEntity.empty().copyWith(
    name: 'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
  );

  EventEntity get event => _event;

  List<PlayerEntity> _players = [];

  List<PlayerEntity> get players => _players;

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

    final numTeams = (_players.length / _event.maxPlayerPerTeam).ceil();

    if (numTeams < 2) {
      return onError?.call('Não é possível gerar eventos com menos de 2 times!');
    }

    final randomTeamNames = List<String>.from(teamNames)..shuffle();

    final teams = randomTeamNames.take(numTeams).map(TeamEntity.empty).toList();

    // Separate players by gender and sort by level (advanced first)
    final women = _players.where((player) => player.isWoman).toList()
      ..sort((a, b) {
        // Sort by level: advanced (2) > intermediate (1) > basic (0)
        final levelOrder = {
          PlayerLevel.advanced: 2,
          PlayerLevel.intermediate: 1,
          PlayerLevel.basic: 0,
        };
        return (levelOrder[b.level] ?? 0).compareTo(levelOrder[a.level] ?? 0);
      });

    final men = _players.where((player) => player.isMan).toList()
      ..sort((a, b) {
        final levelOrder = {
          PlayerLevel.advanced: 2,
          PlayerLevel.intermediate: 1,
          PlayerLevel.basic: 0,
        };
        return (levelOrder[b.level] ?? 0).compareTo(levelOrder[a.level] ?? 0);
      });

    // Calculate how many teams we can fully fill
    final fullTeamsCount = (_players.length / _event.maxPlayerPerTeam).floor();
    final targetTeamsCount = fullTeamsCount;

    // Distribute women in round-robin fashion to balance skill levels
    var teamIndex = 0;
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

    // Distribute men in round-robin fashion to balance skill levels
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

    final result = await _repository.insertOne(
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

  void handleAddPlayer() {
    players.add(PlayerEntity.empty(nameController.text, selectedGender.first));
    nameController.clear();
    selectedGender.clear();
    notifyListeners();
  }

  void handlePlayerChanges(int index, PlayerEntity player) {
    players[index] = player;
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
            .toList()
          ..sort((a, b) => a.compareTo(b));

    if (names.isEmpty) {
      importerController.clear();

      return onError?.call('Nenhum jogador encontrado na lista colada!');
    }

    players.addAll(
      names.map(
        (name) {
          final match = RegExp(r'(.+)\s+-\s+(H|h|M|m)').firstMatch(name);

          if (match == null) {
            return PlayerEntity.empty(name, PlayerGender.unknown);
          }

          final playerName = match.group(1)!;
          final playerGender = match.group(2)!;

          return PlayerEntity.empty(
            playerName,
            playerGender.toLowerCase() == 'm' ? PlayerGender.female : PlayerGender.male,
          );
        },
      ),
    );

    _players = players.toSet().toList();

    players.sort((a, b) => a.name.compareTo(b.name));

    importerController.clear();

    notifyListeners();

    return onSuccess?.call();
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
