import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'event.dart';

abstract class EventViewModel extends State<Event> {
  L10n get l10n => L10n.of(context);

  SharedPreferencesService get prefs => Injector.instance.get();

  final WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();

  bool _loading = false;

  bool get loading => _loading;

  bool _sharing = false;

  bool get sharing => _sharing;

  final bool _hasTeamWithMaxWinsInARow = false;

  bool get hasTeamWithMaxWinsInARow => _hasTeamWithMaxWinsInARow;

  late EventEntity _event =
      prefs.find<EventEntity>((e) => e.id == widget.eventId) ??
      EventEntity.empty();

  EventEntity get event => _event;

  MatchEntity? get currentMatch => _event.currentMatch;

  Future<void> reloadEvent({
    Future<void> Function(String message)? onMaxWinsInARow,
    Future<void> Function(String message)? onNeedJokers,
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
      _sharing = false;
    });

    _event = prefs.find<EventEntity>((e) => e.id == _event.id) ?? _event;

    final nextMatchData = event.nextMatchData();

    if (nextMatchData != null) {
      final (first, second, queue) = nextMatchData;

      final teamWithMaxWinsInARow = event.teamWithMaxWinsInARow();

      if (teamWithMaxWinsInARow != null) {
        await onMaxWinsInARow?.call(
          l10n.maxWinsInARowMessage(
            teamWithMaxWinsInARow.name,
            event.maxWinsInARow,
            first.name,
            second.name,
          ),
        );
      }

      if (first.players.length < event.maxPlayerPerTeam) {
        await onNeedJokers?.call(
          l10n.teamIncompleteError(
            first.name,
            event.maxPlayerPerTeam - first.players.length,
          ),
        );
      }

      if (second.players.length < event.maxPlayerPerTeam) {
        await onNeedJokers?.call(
          l10n.teamIncompleteError(
            second.name,
            event.maxPlayerPerTeam - second.players.length,
          ),
        );
      }

      final match = MatchEntity.create(
        eventId: event.id,
        name: (event.matches.length + 1).toString(),
        firstTeam: first,
        secondTeam: second,
        maxScore: event.maxScore,
        halfScoreToEliminate: event.halfScoreToEliminate,
      );

      _event = _event.copyWith(
        matches: [match, ...event.matches],
        queue: queue.map((team) => team.id).toList(),
      );

      await prefs.put<EventEntity>(_event);

      return setState(() => _loading = false);
    }

    return setState(() {
      _loading = false;
      _event = event;
    });
  }

  Future<void> endEvent({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() => _loading = true);

    if (event.endedMatches.isEmpty) {
      await prefs.delete<EventEntity>(event);

      return onSuccess?.call();
    }

    _event = _event.copyWith(
      ended: true,
      matches: _event.matches
          .map((match) => match.copyWith(ended: true))
          .toList(),
    );

    await prefs.put<EventEntity>(_event);

    return onSuccess?.call();
  }

  Future<void> shareEvent({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() {
      _sharing = true;
    });

    final bytes = await widgetsToImageController.capturePng(
      waitForAnimations: true,
      delayMs: 100,
    );

    if (bytes == null) {
      return onError?.call(l10n.shareEventError);
    }

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            bytes,
            name: '${event.name}.png',
            mimeType: 'image/png',
          ),
        ],
      ),
    );

    return setState(() {
      _sharing = false;

      return onSuccess?.call();
    });
  }
}
