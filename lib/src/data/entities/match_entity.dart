import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';

part 'match_entity.freezed.dart';
part 'match_entity.g.dart';

@freezed
abstract class MatchEntity with _$MatchEntity {
  const MatchEntity._();

  const factory MatchEntity({
    required int id,
    required int eventId,
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

  factory MatchEntity.fromJson(Map<String, dynamic> json) => _$MatchEntityFromJson(json);

  factory MatchEntity.fromDrift(EventMatchData data) {
    return MatchEntity(
      id: data.id,
      eventId: data.eventId,
      name: data.name,
      maxScore: data.maxScore,
      firstTeam: TeamEntity.empty(''),
      secondTeam: TeamEntity.empty(''),
      scores: [],
      halfScoreToEliminate: data.halfScoreToEliminate,
      ended: data.ended,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      endedAt: data.endedAt,
    );
  }

  factory MatchEntity.withAllData(MatchWithAllDataData data) {
    final firstTeamSource = json.decode(data.firstTeam);
    final secondTeamSource = json.decode(data.secondTeam);

    return MatchEntity(
      id: data.id,
      eventId: data.eventId,
      name: data.name,
      maxScore: data.maxScore,
      firstTeam: TeamEntity(
        id: firstTeamSource['id'] as int,
        eventId: firstTeamSource['eventId'] as int,
        name: firstTeamSource['name'] as String,
        players: List.from(
          (firstTeamSource['players'] as List).map(
            (player) => PlayerEntity(
              id: player['id'] as int,
              name: player['name'] as String,
              gender: PlayerGender.fromValue(player['gender'] as String),
              level: PlayerLevel.fromValue(player['level'] as String),
              createdAt: DateTime.parse(player['createdAt'] as String),
              updatedAt: DateTime.parse(player['updatedAt'] as String),
            ),
          ),
        ),
        createdAt: DateTime.parse(firstTeamSource['createdAt'] as String),
        updatedAt: DateTime.parse(firstTeamSource['updatedAt'] as String),
      ),
      secondTeam: TeamEntity(
        id: secondTeamSource['id'] as int,
        eventId: secondTeamSource['eventId'] as int,
        name: secondTeamSource['name'] as String,
        players: List.from(
          (secondTeamSource['players'] as List).map(
            (player) => PlayerEntity(
              id: player['id'] as int,
              name: player['name'] as String,
              gender: PlayerGender.fromValue(player['gender'] as String),
              level: PlayerLevel.fromValue(player['level'] as String),
              createdAt: DateTime.parse(player['createdAt'] as String),
              updatedAt: DateTime.parse(player['updatedAt'] as String),
            ),
          ),
        ),
        createdAt: DateTime.parse(secondTeamSource['createdAt'] as String),
        updatedAt: DateTime.parse(secondTeamSource['updatedAt'] as String),
      ),
      scores: List.from(
        (json.decode(data.scores) as List).map(
          (source) => ScoreEntity(
            id: source['id'] as int,
            matchId: source['matchId'] as int,
            teamId: source['teamId'] as int,
            createdAt: DateTime.parse(source['createdAt'] as String),
            updatedAt: DateTime.parse(source['updatedAt'] as String),
          ),
        ),
      ),
      halfScoreToEliminate: data.halfScoreToEliminate,
      ended: data.ended,
      createdAt: DateTime.parse(data.createdAt),
      updatedAt: DateTime.parse(data.updatedAt),
      endedAt: switch (data.endedAt.isEmpty) {
        true => null,
        false => DateTime.parse(data.endedAt),
      },
    );
  }

  factory MatchEntity.fromSupabase(Map<String, dynamic> data) {
    return MatchEntity(
      id: data['id'] as int,
      eventId: data['event_id'] as int,
      name: data['name'] as String,
      firstTeam: data['first_team'] != null
          ? TeamEntity.fromSupabase(data['first_team'] as Map<String, dynamic>)
          : TeamEntity.empty(''),
      secondTeam: data['second_team'] != null
          ? TeamEntity.fromSupabase(data['second_team'] as Map<String, dynamic>)
          : TeamEntity.empty(''),
      scores: List.from(
        (data['scores'] as List<dynamic>?)?.map((e) => ScoreEntity.fromSupabase(e as Map<String, dynamic>)).toList() ??
            [],
      ),
      halfScoreToEliminate: data['half_score_to_eliminate'] as bool,
      maxScore: data['max_score'] as int,
      ended: data['ended'] as bool,
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
      endedAt: data['ended_at'] != null ? DateTime.parse(data['ended_at'] as String) : null,
    );
  }

  int get firstTeamScore => scores.where((score) => score.teamId == firstTeam.id && !score.reversed).length;

  int get secondTeamScore => scores.where((score) => score.teamId == secondTeam.id && !score.reversed).length;

  bool get firstTeamScoreByOne {
    if (halfScoreToEliminate) {
      return (firstTeamScore == maxScore / 2 - 1 && secondTeamScore == 0) || firstTeamScore == maxScore - 1;
    }

    return (firstTeamScore == maxScore - 1);
  }

  bool get secondTeamScoreByOne {
    if (halfScoreToEliminate) {
      return (secondTeamScore == maxScore / 2 - 1 && firstTeamScore == 0) || secondTeamScore == maxScore - 1;
    }

    return (secondTeamScore == maxScore - 1);
  }

  bool get isByOne => firstTeamScoreByOne || secondTeamScoreByOne;

  bool get isTiedWhenByOne => firstTeamScore == secondTeamScore && isByOne;

  bool get firstTeamWon {
    if (halfScoreToEliminate) {
      return firstTeamScore == maxScore || (firstTeamScore == (maxScore / 2) && secondTeamScore == 0);
    }

    return firstTeamScore == maxScore;
  }

  bool get secondTeamWon {
    if (halfScoreToEliminate) {
      return secondTeamScore == maxScore || (secondTeamScore == (maxScore / 2) && firstTeamScore == 0);
    }

    return secondTeamScore == maxScore;
  }

  bool get isEmpty => id == -1;

  bool get isNotEmpty => !isEmpty;

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
    return '$name - ${firstTeam.name} ($firstTeamScore) vs ($secondTeamScore) ${secondTeam.name}';
  }

  ScoreEntity get lastScore {
    final realScores = scores.where((score) => !score.reversed).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    if (realScores.isEmpty) return ScoreEntity.empty();
    return realScores.first;
  }

  factory MatchEntity.empty() {
    return MatchEntity(
      id: -1,
      eventId: -1,
      name: '',
      firstTeam: TeamEntity.empty(''),
      secondTeam: TeamEntity.empty(''),
      halfScoreToEliminate: false,
      maxScore: 0,
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }
}
