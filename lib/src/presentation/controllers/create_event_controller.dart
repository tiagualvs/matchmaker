import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';

class CreateEventController extends ChangeNotifier {
  CreateEventController(this._repository);

  final EventsRepository _repository;

  bool _loading = false;

  bool get loading => _loading;

  EventEntity _event = EventEntity.empty().copyWith(
    name: 'Evento do dia ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
  );

  EventEntity get event => _event;

  final List<PlayerEntity> _players = [];

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

    final teams = List.generate(numTeams, (index) => TeamEntity.empty('Time ${index + 1}'));

    final women = _players.where((player) => player.isWoman).toList()..shuffle();

    final men = _players.where((player) => player.isMan).toList()..shuffle();

    // Calculate how many teams we can fully fill
    final fullTeamsCount = (_players.length / _event.maxPlayerPerTeam).floor();

    // We treat the "fullTeamsCount" teams as priority targets to be balanced.
    // If (numTeams > fullTeamsCount), the last team takes the overflow.
    // Edge case: if fullTeamsCount == numTeams, all teams are targets.
    // Edge case: if fullTeamsCount == 0 (should shouldn't happen with numTeams >= 2 check usually,
    // unless max is huge, but then numTeams would be 1 and error out),
    // but code handles targetTeamsCount=0 gracefully by skipping loop and dumping to remainder.
    final targetTeamsCount = fullTeamsCount;

    var teamIndex = 0;

    for (final woman in women) {
      bool placed = false;
      // Distribute Round-Robin only among the Target Teams
      if (targetTeamsCount > 0) {
        for (int i = 0; i < targetTeamsCount; i++) {
          if (teams[teamIndex].players.length < _event.maxPlayerPerTeam) {
            teams[teamIndex] = teams[teamIndex].copyWith(
              players: [
                ...teams[teamIndex].players,
                woman,
              ],
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
          players: [
            ...teams[remainderIndex].players,
            woman,
          ],
        );
      }
    }

    teamIndex = 0;

    for (final man in men) {
      bool placed = false;
      if (targetTeamsCount > 0) {
        for (int i = 0; i < targetTeamsCount; i++) {
          if (teams[teamIndex].players.length < _event.maxPlayerPerTeam) {
            teams[teamIndex] = teams[teamIndex].copyWith(
              players: [
                ...teams[teamIndex].players,
                man,
              ],
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
          players: [
            ...teams[remainderIndex].players,
            man,
          ],
        );
      }
    }

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
    _loading = true;

    notifyListeners();

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
      return onError?.call('Nenhum jogador encontrado!');
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

    players.sort((a, b) => a.name.compareTo(b.name));

    importerController.clear();

    _loading = false;

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
