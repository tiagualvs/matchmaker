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
    final numTeams = (_players.length / _event.maxPlayerPerTeam).ceil();

    if (numTeams < 2) {
      return onError?.call('Não é possível gerar eventos com menos de 2 times!');
    }

    final teams = List.generate(numTeams, (index) => TeamEntity.empty('Time ${index + 1}'));

    final women = _players.where((player) => player.isWoman).toList()..shuffle();

    final men = _players.where((player) => player.isMan).toList()..shuffle();

    var teamIndex = 0;

    for (final woman in women) {
      while (teams[teamIndex].players.length >= _event.maxPlayerPerTeam) {
        teamIndex = (teamIndex + 1) % numTeams;
      }
      teams[teamIndex] = teams[teamIndex].copyWith(
        players: [
          ...teams[teamIndex].players,
          woman,
        ],
      );
      teamIndex = (teamIndex + 1) % numTeams;
    }

    teamIndex = 0;

    for (final man in men) {
      while (teams[teamIndex].players.length >= _event.maxPlayerPerTeam) {
        teamIndex = (teamIndex + 1) % numTeams;
      }
      teams[teamIndex] = teams[teamIndex].copyWith(
        players: [
          ...teams[teamIndex].players,
          man,
        ],
      );
      teamIndex = (teamIndex + 1) % numTeams;
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
        maxPlayerPerTeam: _event.maxPlayerPerTeam,
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
    _event = EventEntity.empty();
    _loading = false;
  }
}
