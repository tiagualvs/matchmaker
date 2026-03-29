import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

import 'add_player.dart';

abstract class AddPlayerViewModel extends State<AddPlayer> {
  L10n get l10n => L10n.of(context);

  SharedPreferencesService get prefs => Injector.instance.get();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;

  late EventEntity _event =
      prefs.find<EventEntity>((e) => e.id == widget.eventId) ??
      EventEntity.empty();

  EventEntity get event => _event;

  late TeamEntity _team = TeamEntity.create(
    eventId: _event.id,
    name: '',
    players: [],
  );

  TeamEntity get team => _team;

  List<PlayerEntity> get players => _team.players;

  Future<void> handleInsertPlayer(
    PlayerEntity player, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() => loading = true);

    final existingPlayer = prefs.find<PlayerEntity>(
      (p) => p.name == player.name,
    );

    if (existingPlayer == null) {
      final saved = await prefs.put<PlayerEntity>(player);

      if (!saved) {
        return setState(() {
          loading = false;

          return onError?.call(l10n.failedToSavePlayerError);
        });
      }
    } else {
      player = existingPlayer;
    }

    if (_event.hasPlayer(player.id)) {
      return setState(() {
        loading = false;

        return onError?.call(l10n.playerAlreadyInTeamError);
      });
    }

    return setState(() {
      loading = false;

      _team = _team.copyWith(
        players: [
          ..._team.players,
          player,
        ],
        updatedAt: Timestamp.now(),
      );

      return onSuccess?.call();
    });
  }

  Future<void> save({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => loading = true);

      _event = _event.copyWith(
        teams: [
          ..._event.teams,
          _team,
        ],
        queue: [
          ..._event.queue,
          _team.id,
        ],
        updatedAt: Timestamp.now(),
      );

      final saved = await prefs.put<EventEntity>(_event);

      if (!saved) {
        return setState(() {
          loading = false;

          return onError?.call(l10n.failedToSaveEventError);
        });
      }

      return setState(() {
        loading = false;

        return onSuccess?.call();
      });
    }
  }

  void setName(String name) {
    setState(() {
      _team = _team.copyWith(name: name);
    });
  }
}
