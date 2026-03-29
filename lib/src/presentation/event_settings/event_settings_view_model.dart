import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

import 'event_settings.dart';

abstract class EventSettingsViewModel extends State<EventSettings> {
  L10n get l10n => L10n.of(context);

  SharedPreferencesService get prefs => Injector.instance.get();

  bool _loading = false;

  bool get loading => _loading;

  late EventEntity _event =
      prefs.find<EventEntity>((e) => e.id == widget.eventId) ??
      EventEntity.empty();

  EventEntity get event => _event;

  Future<void> save({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() => _loading = true);

    final saved = await prefs.put<EventEntity>(
      event.copyWith(updatedAt: Timestamp.now()),
    );

    if (!saved) {
      return setState(() {
        _loading = false;

        return onError?.call(l10n.failedToSaveEventError);
      });
    }

    return onSuccess?.call();
  }

  void setName(String name) {
    setState(() {
      _event = _event.copyWith(name: name);
    });
  }

  void setMaxScore(int maxScore) {
    setState(() {
      _event = _event.copyWith(maxScore: maxScore);
    });
  }

  void setMaxPlayerPerTeam(int maxPlayerPerTeam) {
    setState(() {
      _event = _event.copyWith(maxPlayerPerTeam: maxPlayerPerTeam);
    });
  }

  void setMaxWinsInARow(int maxWinsInARow) {
    setState(() {
      _event = _event.copyWith(maxWinsInARow: maxWinsInARow);
    });
  }

  void setHalfScoreToEliminate(bool halfScoreToEliminate) {
    setState(() {
      _event = _event.copyWith(
        halfScoreToEliminate: halfScoreToEliminate,
        matches: List.from(
          _event.matches.map(
            (m) => m.ended
                ? m
                : m.copyWith(halfScoreToEliminate: halfScoreToEliminate),
          ),
        ),
      );
    });
  }

  void setBalancedByGender(bool balancedByGender) {
    setState(() {
      _event = _event.copyWith(balancedByGender: balancedByGender);
    });
  }

  void setBalancedByLevel(bool balancedByLevel) {
    setState(() {
      _event = _event.copyWith(balancedByLevel: balancedByLevel);
    });
  }
}
