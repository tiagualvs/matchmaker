import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/common/shared/id.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';

part 'match_entity.freezed.dart';
part 'match_entity.g.dart';

@freezed
abstract class MatchEntity with _$MatchEntity {
  const MatchEntity._();

  const factory MatchEntity({
    required String id,
    required String eventId,
    required String name,
    required TeamEntity firstTeam,
    required TeamEntity secondTeam,
    @Default([]) List<ScoreEntity> scores,
    required int maxScore,
    required bool halfScoreToEliminate,
    @Default(false) bool ended,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? endedAt,
  }) = _MatchEntity;

  factory MatchEntity.fromJson(Map<String, dynamic> json) =>
      _$MatchEntityFromJson(json);

  factory MatchEntity.create({
    required String eventId,
    required String name,
    required TeamEntity firstTeam,
    required TeamEntity secondTeam,
    required int maxScore,
    required bool halfScoreToEliminate,
  }) {
    return MatchEntity(
      id: Id.generate(),
      eventId: eventId,
      name: name,
      firstTeam: firstTeam,
      secondTeam: secondTeam,
      maxScore: maxScore,
      halfScoreToEliminate: halfScoreToEliminate,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  int get firstTeamScore => scores
      .where((score) => score.teamId == firstTeam.id && !score.reversed)
      .length;

  int get secondTeamScore => scores
      .where((score) => score.teamId == secondTeam.id && !score.reversed)
      .length;

  bool get firstTeamScoreByOne {
    if (halfScoreToEliminate) {
      return (firstTeamScore == maxScore / 2 - 1 && secondTeamScore == 0) ||
          firstTeamScore == maxScore - 1;
    }

    return (firstTeamScore == maxScore - 1);
  }

  bool get secondTeamScoreByOne {
    if (halfScoreToEliminate) {
      return (secondTeamScore == maxScore / 2 - 1 && firstTeamScore == 0) ||
          secondTeamScore == maxScore - 1;
    }

    return (secondTeamScore == maxScore - 1);
  }

  bool get isByOne => firstTeamScoreByOne || secondTeamScoreByOne;

  bool get isTiedWhenByOne => firstTeamScore == secondTeamScore && isByOne;

  bool get firstTeamWon {
    if (halfScoreToEliminate) {
      return firstTeamScore == maxScore ||
          (firstTeamScore == (maxScore / 2) && secondTeamScore == 0);
    }

    return firstTeamScore == maxScore;
  }

  bool get secondTeamWon {
    if (halfScoreToEliminate) {
      return secondTeamScore == maxScore ||
          (secondTeamScore == (maxScore / 2) && firstTeamScore == 0);
    }

    return secondTeamScore == maxScore;
  }

  bool get isEmpty => id == Id.min();

  bool get isNotEmpty => !isEmpty;

  bool get isDetached => id == Id.max();

  TeamEntity? get winner {
    if (!ended) return null;

    if (firstTeamWon) return firstTeam;

    if (secondTeamWon) return secondTeam;

    return null;
  }

  TeamEntity? get loser {
    if (!ended) return null;

    if (firstTeamWon) return secondTeam;

    if (secondTeamWon) return firstTeam;

    return null;
  }

  String get details {
    return '${firstTeam.name} ($firstTeamScore) vs ($secondTeamScore) ${secondTeam.name}';
  }

  ScoreEntity get lastScore {
    final realScores = scores.where((score) => !score.reversed).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    if (realScores.isEmpty) return ScoreEntity.empty();
    return realScores.first;
  }

  factory MatchEntity.empty() {
    return MatchEntity(
      id: Id.min(),
      eventId: Id.min(),
      name: '',
      firstTeam: TeamEntity.empty(''),
      secondTeam: TeamEntity.empty(''),
      halfScoreToEliminate: false,
      maxScore: 0,
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }

  factory MatchEntity.detached({
    required String firstTeamName,
    required String secondTeamName,
    int maxScore = 12,
    bool halfScoreToEliminate = false,
  }) {
    return MatchEntity(
      id: Id.max(),
      eventId: Id.max(),
      name: '1',
      firstTeam: TeamEntity(
        id: Id.generate(),
        eventId: Id.max(),
        name: firstTeamName,
        players: [],
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      ),
      secondTeam: TeamEntity(
        id: Id.generate(),
        eventId: Id.max(),
        name: secondTeamName,
        players: [],
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      ),
      halfScoreToEliminate: halfScoreToEliminate,
      maxScore: maxScore,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }
}
