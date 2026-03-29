import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchmaker/src/common/extensions/iterable_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/shared/id.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';
import 'package:matchmaker/src/presentation/match/match.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract class MatchViewModel extends State<Match> {
  L10n get l10n => L10n.of(context);

  SharedPreferencesService get prefs => Injector.instance.get();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    scheduleMicrotask(() async {
      await WakelockPlus.enable();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });
  }

  @override
  void dispose() {
    scheduleMicrotask(() async {
      await WakelockPlus.disable();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    });

    super.dispose();
  }

  final bool _loading = false;

  bool get loading => _loading;

  bool _swapped = false;

  bool get swapped => _swapped;

  bool _writing = false;

  void toggleSwap() => setState(() => _swapped = !_swapped);

  late final EventEntity _event =
      prefs.find<EventEntity>((e) => e.id == widget.eventId) ??
      EventEntity.empty();

  late MatchEntity _match =
      _event.matches.firstWhereOrNull((e) => e.id == widget.matchId) ??
      MatchEntity.detached(
        firstTeamName: l10n.detachedFirstTeamName,
        secondTeamName: l10n.detachedSecondTeamName,
      );

  MatchEntity get match => _match;

  TeamEntity get firstTeam => _match.firstTeam;

  int get firstTeamScore => _match.firstTeamScore;

  bool get firstTeamByOneOrWon =>
      _match.firstTeamScoreByOne || _match.firstTeamWon;

  TeamEntity get secondTeam => _match.secondTeam;

  int get secondTeamScore => _match.secondTeamScore;

  bool get secondTeamByOneOrWon =>
      _match.secondTeamScoreByOne || _match.secondTeamWon;

  Future<void> reverseScore(
    String teamId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final scores = _match.scores
        .where((score) => score.teamId == teamId)
        .toList();

    if (scores.isEmpty) return;

    if (_match.isDetached) {
      return setState(() {
        _match = _match.copyWith(
          scores: List.from(_match.scores)..remove(scores.first),
        );
      });
    }

    if (Id.valid(teamId)) {
      return onError?.call('Invalid team id');
    }

    if (_writing) return;

    setState(() => _writing = true);

    final teamScores = _match.scores.where(
      (score) => score.teamId == teamId && !score.reversed,
    );

    if (teamScores.isEmpty) return;

    final scoreId = teamScores.first.id;

    final index = scores.indexWhere((e) => e.id == scoreId);

    if (index == -1) return;

    scores[index] = scores[index].copyWith(
      reversed: true,
      updatedAt: Timestamp.now(),
    );

    _match = _match.copyWith(
      scores: scores,
      updatedAt: Timestamp.now(),
    );

    final saved = await prefs.put<EventEntity>(
      _event.copyWith(
        matches: List.from(_event.matches)..[0] = _match,
        updatedAt: Timestamp.now(),
      ),
    );

    if (!saved) {
      return setState(() {
        _writing = false;

        return onError?.call('Failed to save match');
      });
    }

    return setState(() => _writing = false);
  }

  Future<void> incrementScore(
    String teamId, {
    required FutureOr<bool> Function(TeamEntity team, String score)
    confirmEndOfMatch,
    void Function(String error)? onError,
  }) async {
    if (_match.ended) return;

    final score = ScoreEntity.create(
      matchId: _match.id,
      teamId: teamId,
    );

    if (_match.isDetached) {
      _match = _match.copyWith(
        scores: List.from(_match.scores)
          ..add(score)
          ..sort((a, b) => b.id.compareTo(a.id)),
      );

      setState(() {});

      if (_match.isTiedWhenByOne) {
        _match = _match.copyWith(
          maxScore: _match.maxScore + 1,
        );
      }

      if (_match.firstTeamWon || _match.secondTeamWon) {
        final winner = _match.firstTeamWon
            ? _match.firstTeam
            : _match.secondTeam;
        final currentScore = _match.firstTeamWon
            ? '${_match.firstTeamScore} x ${_match.secondTeamScore}'
            : '${_match.secondTeamScore} x ${_match.firstTeamScore}';

        if (!await confirmEndOfMatch(winner, currentScore)) {
          _match = _match.copyWith(
            scores: List.from(_match.scores)..removeLast(),
          );
        } else {
          _match = _match.copyWith(ended: true);
        }
      }

      return setState(() {});
    }

    if (!Id.valid(teamId)) return onError?.call('Invalid team id');

    if (_writing) return;

    setState(() {
      _writing = true;

      _match = _match.copyWith(
        scores: [score, ..._match.scores],
      );
    });

    if (_match.isTiedWhenByOne) {
      _match = _match.copyWith(maxScore: _match.maxScore + 1);
    }

    if (_match.firstTeamWon || _match.secondTeamWon) {
      final winner = _match.firstTeamWon ? _match.firstTeam : _match.secondTeam;
      final currentScore = _match.firstTeamWon
          ? '${_match.firstTeamScore} x ${_match.secondTeamScore}'
          : '${_match.secondTeamScore} x ${_match.firstTeamScore}';

      if (!await confirmEndOfMatch(winner, currentScore)) {
        return setState(() {
          _writing = false;

          _match = _match.copyWith(
            scores: List.from(_match.scores)..remove(score),
          );
        });
      }

      _match = _match.copyWith(ended: true);
    }

    final event = prefs.find<EventEntity>((e) => e.id == _match.eventId);

    if (event == null) return;

    final matches = List<MatchEntity>.from(event.matches);

    final index = matches.indexWhere((m) => m.id == _match.id);

    if (index == -1) return;

    matches[index] = _match;

    await prefs.put<EventEntity>(event.copyWith(matches: matches));

    setState(() => _writing = false);
  }

  void restartDetachedMatch() {
    setState(() {
      _match = _match.copyWith(
        ended: false,
        scores: [],
      );
    });
  }

  void setMaxScore(int maxScore) {
    _match = _match.copyWith(maxScore: maxScore);
    setState(() {});
  }

  void setHalfScoreToEliminate(bool halfScoreToEliminate) {
    _match = _match.copyWith(halfScoreToEliminate: halfScoreToEliminate);
    setState(() {});
  }
}
