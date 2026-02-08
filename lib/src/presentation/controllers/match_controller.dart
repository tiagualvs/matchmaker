import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_repository.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class MatchController extends ChangeNotifier {
  MatchController(this._matchesRepository, this._scoresRepository);

  void setState([void Function()? func]) {
    func?.call();
    return notifyListeners();
  }

  final MatchesRepository _matchesRepository;

  final ScoresRepository _scoresRepository;

  bool _loading = true;

  bool get loading => _loading;

  bool _swapped = false;

  bool get swapped => _swapped;

  void toggleSwap() => setState(() => _swapped = !_swapped);

  MatchEntity match = MatchEntity.empty();

  Future<void> loadDependencies(
    int matchId, {
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
    });

    await WakelockPlus.enable();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    if (matchId == -99) {
      return setState(() {
        match = MatchEntity.detached();

        _loading = false;
      });
    }

    final result = await _matchesRepository.findOne(matchId);

    return result.fold(
      (value) {
        return setState(() {
          match = value;

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
    if (match.isDetached) {
      return setState(() {
        final scores = match.scores.where((score) => score.teamId == teamId);

        if (scores.isEmpty) return;

        match = match.copyWith(
          scores: List.from(match.scores)..remove(scores.first),
        );
      });
    }

    final scores = match.scores.where((score) => score.teamId == teamId && !score.reversed);

    if (scores.isEmpty) return;

    final scoreId = scores.first.id;

    final result = await _scoresRepository.updateOne(scoreId, true);

    return result.fold(
      (score) async {
        return setState(() {
          final index = match.scores.indexWhere((element) => element.id == scoreId);

          match = match.copyWith(
            scores: List.from(match.scores)
              ..[index] = score
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
          );
        });
      },
      (error) {
        return onError?.call(error.toString());
      },
    );
  }

  Future<void> incrementScore(
    int teamId, {
    required FutureOr<bool> Function(TeamEntity team, String score) confirmEndOfMatch,
    void Function(String error)? onError,
  }) async {
    if (match.ended) return;

    if (match.isDetached) {
      setState(() async {
        match = match.copyWith(
          scores: List.from(match.scores)
            ..add(
              ScoreEntity(
                id: match.scores.length + 1,
                matchId: match.id,
                teamId: teamId,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            )
            ..sort((a, b) => b.id.compareTo(a.id)),
        );
      });

      if (match.isTiedWhenByOne) {
        setState(() {
          match = match.copyWith(
            maxScore: match.maxScore + 1,
          );
        });
      }

      if (match.firstTeamWon || match.secondTeamWon) {
        final winner = match.firstTeamWon ? match.firstTeam : match.secondTeam;
        final currentScore = match.firstTeamWon
            ? '${match.firstTeamScore} x ${match.secondTeamScore}'
            : '${match.secondTeamScore} x ${match.firstTeamScore}';

        if (!await confirmEndOfMatch(winner, currentScore)) {
          setState(() {
            match = match.copyWith(
              scores: List.from(match.scores)..removeLast(),
            );
          });
        } else {
          setState(() {
            match = match.copyWith(ended: true);
          });
        }
      }

      return;
    }

    final result0 = await _scoresRepository.insertOne(
      InsertOneScoreParams(
        matchId: match.id,
        teamId: teamId,
      ),
    );

    if (result0.hasError) return onError?.call(result0.error.toString());

    final score = result0.value;

    setState(() {
      match = match.copyWith(
        scores: [score, ...match.scores],
      );
    });

    if (match.isTiedWhenByOne) {
      final result = await _matchesRepository.updateOne(
        match.id,
        UpdateOneMatchParams(maxScore: match.maxScore + 1),
      );

      setState(() {
        match = result.fold((ok) => ok.copyWith(scores: match.scores), (_) => match);
      });
    }

    if (match.firstTeamWon || match.secondTeamWon) {
      final winner = match.firstTeamWon ? match.firstTeam : match.secondTeam;
      final currentScore = match.firstTeamWon
          ? '${match.firstTeamScore} x ${match.secondTeamScore}'
          : '${match.secondTeamScore} x ${match.firstTeamScore}';

      if (!await confirmEndOfMatch(winner, currentScore)) {
        final deleteResult = await _scoresRepository.deleteOne(score.id);

        return deleteResult.fold(
          (_) {
            return setState(() {
              match = match.copyWith(scores: List.from(match.scores)..remove(score));
            });
          },
          (err) {
            return onError?.call(err.toString());
          },
        );
      }

      final result = await _matchesRepository.updateOne(
        match.id,
        const UpdateOneMatchParams(ended: true),
      );

      setState(() {
        match = result.fold((ok) => ok.copyWith(scores: match.scores), (_) => match);
      });
    }
  }

  void restartDetachedMatch() {
    setState(() {
      match = match.copyWith(
        ended: false,
        scores: [],
      );
    });
  }
}
