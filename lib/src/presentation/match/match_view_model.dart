import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_repository.dart';
import 'package:matchmaker/src/presentation/match/match.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract class MatchViewModel extends State<Match> {
  final MatchesRepository _matchesRepository = Injector.instance.get();
  final ScoresRepository _scoresRepository = Injector.instance.get();

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

  bool _loading = false;

  bool get loading => _loading;

  bool _swapped = false;

  bool get swapped => _swapped;

  bool _writing = false;

  void toggleSwap() => setState(() => _swapped = !_swapped);

  late MatchEntity _match = widget.match ?? MatchEntity.detached();

  MatchEntity get match => _match;

  TeamEntity get firstTeam => _match.firstTeam;

  int get firstTeamScore => _match.firstTeamScore;

  bool get firstTeamByOneOrWon =>
      _match.firstTeamScoreByOne || _match.firstTeamWon;

  TeamEntity get secondTeam => _match.secondTeam;

  int get secondTeamScore => _match.secondTeamScore;

  bool get secondTeamByOneOrWon =>
      _match.secondTeamScoreByOne || _match.secondTeamWon;

  set match(MatchEntity match) => setState(() {
    _match = match;
  });

  Future<void> loadDependencies(
    int matchId, {
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
    });

    if (matchId == -99) {
      return setState(() {
        _match = MatchEntity.detached();

        _loading = false;
      });
    }

    final result = await _matchesRepository.findOne(matchId);

    return result.fold(
      (value) {
        return setState(() {
          _match = value;

          _loading = false;
        });
      },
      (error) {
        return setState(() {
          _loading = false;

          return onError?.call(error.toString());
        });
      },
    );
  }

  Future<void> reverseScore(
    int teamId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    if (_match.isDetached) {
      return setState(() {
        final scores = _match.scores.where((score) => score.teamId == teamId);

        if (scores.isEmpty) return;

        _match = _match.copyWith(
          scores: List.from(_match.scores)..remove(scores.first),
        );
      });
    }

    final scores = _match.scores.where(
      (score) => score.teamId == teamId && !score.reversed,
    );

    if (scores.isEmpty) return;

    if (_writing) return;

    setState(() => _writing = true);

    final scoreId = scores.first.id;

    final result = await _scoresRepository.updateOne(scoreId, true);

    return result.fold(
      (score) async {
        return setState(() {
          _writing = false;

          final index = _match.scores.indexWhere(
            (element) => element.id == scoreId,
          );

          _match = _match.copyWith(
            scores: List.from(_match.scores)
              ..[index] = score
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
          );
        });
      },
      (error) {
        return setState(() {
          _writing = false;

          return onError?.call(error.toString());
        });
      },
    );
  }

  Future<void> incrementScore(
    int teamId, {
    required FutureOr<bool> Function(TeamEntity team, String score)
    confirmEndOfMatch,
    void Function(String error)? onError,
  }) async {
    if (_match.ended) return;

    if (_match.isDetached) {
      setState(() async {
        _match = _match.copyWith(
          scores: List.from(_match.scores)
            ..add(
              ScoreEntity(
                id: _match.scores.length + 1,
                matchId: _match.id,
                teamId: teamId,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            )
            ..sort((a, b) => b.id.compareTo(a.id)),
        );
      });

      if (_match.isTiedWhenByOne) {
        setState(() {
          _match = _match.copyWith(
            maxScore: _match.maxScore + 1,
          );
        });
      }

      if (_match.firstTeamWon || _match.secondTeamWon) {
        final winner = _match.firstTeamWon
            ? _match.firstTeam
            : _match.secondTeam;
        final currentScore = _match.firstTeamWon
            ? '${_match.firstTeamScore} x ${_match.secondTeamScore}'
            : '${_match.secondTeamScore} x ${_match.firstTeamScore}';

        if (!await confirmEndOfMatch(winner, currentScore)) {
          setState(() {
            _match = _match.copyWith(
              scores: List.from(_match.scores)..removeLast(),
            );
          });
        } else {
          setState(() {
            _match = _match.copyWith(ended: true);
          });
        }
      }

      return;
    }

    if (_writing) return;

    setState(() => _writing = true);

    final result0 = await _scoresRepository.insertOne(
      InsertOneScoreParams(
        matchId: _match.id,
        teamId: teamId,
      ),
    );

    if (result0.hasError) return onError?.call(result0.error.toString());

    final score = result0.value;

    setState(() {
      _match = _match.copyWith(
        scores: [score, ..._match.scores],
      );
    });

    if (_match.isTiedWhenByOne) {
      final result = await _matchesRepository.updateOne(
        _match.id,
        UpdateOneMatchParams(maxScore: _match.maxScore + 1),
      );

      setState(() {
        _match = result.fold(
          (ok) => ok.copyWith(scores: _match.scores),
          (_) => _match,
        );
      });
    }

    if (_match.firstTeamWon || _match.secondTeamWon) {
      final winner = _match.firstTeamWon ? _match.firstTeam : _match.secondTeam;
      final currentScore = _match.firstTeamWon
          ? '${_match.firstTeamScore} x ${_match.secondTeamScore}'
          : '${_match.secondTeamScore} x ${_match.firstTeamScore}';

      if (!await confirmEndOfMatch(winner, currentScore)) {
        final deleteResult = await _scoresRepository.deleteOne(score.id);

        return deleteResult.fold(
          (_) {
            return setState(() {
              _writing = false;
              _match = _match.copyWith(
                scores: List.from(_match.scores)..remove(score),
              );
            });
          },
          (err) {
            return onError?.call(err.toString());
          },
        );
      }

      final result = await _matchesRepository.updateOne(
        _match.id,
        const UpdateOneMatchParams(ended: true),
      );

      setState(() {
        _match = result.fold(
          (ok) => ok.copyWith(scores: _match.scores),
          (_) => _match,
        );
      });
    }

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
}
