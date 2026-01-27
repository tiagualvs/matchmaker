import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/repositories/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/scores_repository.dart';

class MatchController extends ChangeNotifier {
  MatchController(this._matchesRepository, this._scoresRepository);

  final MatchesRepository _matchesRepository;

  final ScoresRepository _scoresRepository;

  MatchEntity _match = MatchEntity.empty();

  MatchEntity get match => _match;

  Future<void> loadDependencies(int matchId) async {
    final result = await _matchesRepository.findOne(matchId);

    _match = result.fold((ok) => ok, (_) => _match);

    notifyListeners();
  }

  Future<void> reverseScore(
    int teamId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    final scores = _match.scores.where((score) => score.teamId == teamId && !score.reversed);

    if (scores.isEmpty) return;

    final scoreId = scores.first.id;

    final result = await _scoresRepository.updateOne(scoreId, true);

    return result.fold(
      (score) async {
        final index = _match.scores.indexWhere((element) => element.id == scoreId);

        _match = _match.copyWith(
          scores: List.from(_match.scores)
            ..[index] = score
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
        );

        notifyListeners();
      },
      (error) {
        return onError?.call(error.toString());
      },
    );
  }

  Future<void> incrementScore(
    int teamId, {
    void Function(String error)? onError,
  }) async {
    if (_match.ended) return;

    final result = await _scoresRepository.insertOne(
      InsertOneScoreParams(matchId: _match.id, teamId: teamId),
    );

    return result.fold(
      (score) async {
        _match = _match.copyWith(
          scores: [
            score,
            ..._match.scores,
          ]..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
        );

        if (_match.isTiedWhenByOne) {
          final result = await _matchesRepository.updateOne(
            _match.id,
            UpdateOneMatchParams(maxScore: _match.maxScore + 1),
          );

          _match = result.fold((ok) => ok, (_) => _match);
        }

        if (_match.firstTeamWon || _match.secondTeamWon) {
          final result = await _matchesRepository.updateOne(
            _match.id,
            UpdateOneMatchParams(ended: true, endedAt: DateTime.now()),
          );

          _match = result.fold((ok) => ok, (_) => _match);
        }

        notifyListeners();
      },
      (error) {
        return onError?.call(error.toString());
      },
    );
  }
}
