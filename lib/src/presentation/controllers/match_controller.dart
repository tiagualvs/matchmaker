import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/scores_repository.dart';

class MatchController extends ChangeNotifier {
  MatchController(this._matchesRepository, this._scoresRepository);

  final MatchesRepository _matchesRepository;

  final ScoresRepository _scoresRepository;

  MatchEntity _match = MatchEntity.empty();

  MatchEntity get match => _match;

  Future<void> loadDependencies(String matchId) async {
    final result = await _matchesRepository.findOne(matchId);

    _match = result.fold((ok) => ok, (_) => _match);

    notifyListeners();
  }

  Future<void> incrementScore(
    ScoreEntity score, {
    required void Function(TeamEntity team) onEnd,
  }) async {
    final result = await _scoresRepository.insertOne(score);

    return result.fold(
      (score) async {
        _match = _match.copyWith(
          scores: [
            score,
            ..._match.scores,
          ]..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
        );

        if (_match.isTiedWhenByOne) {
          _match = _match.copyWith(maxScore: _match.maxScore + 1);

          await _matchesRepository.updateOne(_match);
        }

        if (_match.firstTeamWon || _match.secondTeamWon) {
          _match = _match.copyWith(ended: true, endedAt: DateTime.now());

          await _matchesRepository.updateOne(_match);
        }

        notifyListeners();

        if (_match.firstTeamWon) {
          return onEnd(_match.firstTeam);
        }

        if (_match.secondTeamWon) {
          return onEnd(_match.secondTeam);
        }
      },
      (error) {},
    );
  }
}
