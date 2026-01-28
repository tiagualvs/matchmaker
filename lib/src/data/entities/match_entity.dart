import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';

part 'match_entity.freezed.dart';
part 'match_entity.g.dart';

@freezed
abstract class MatchEntity with _$MatchEntity {
  const MatchEntity._();

  const factory MatchEntity({
    required int id,
    @JsonKey(name: 'event_id') required int eventId,
    required String name,
    @JsonKey(name: 'first_team') required TeamEntity firstTeam,
    @JsonKey(name: 'second_team') required TeamEntity secondTeam,
    @Default([]) List<ScoreEntity> scores,
    @JsonKey(name: 'max_score') required int maxScore,
    @Default(false) bool ended,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
  }) = _MatchEntity;

  factory MatchEntity.fromJson(Map<String, dynamic> json) => _$MatchEntityFromJson(json);

  factory MatchEntity.fromSqlite(Map<String, dynamic> row) {
    final scores = switch (row['scores']) {
      String s => (json.decode(s) as List).map((e) => ScoreEntity.fromSqlite(e as Map<String, dynamic>)).toList(),
      List l => l.map((e) => ScoreEntity.fromSqlite(e as Map<String, dynamic>)).toList(),
      _ => <ScoreEntity>[],
    };
    return MatchEntity(
      id: row['id'] as int,
      eventId: row['event_id'] as int,
      name: row['name'] as String,
      maxScore: row['max_score'] as int,
      firstTeam: row['first_team'] != null
          ? TeamEntity.fromSqlite(json.decode(row['first_team']) as Map<String, dynamic>)
          : TeamEntity.empty(''),
      secondTeam: row['second_team'] != null
          ? TeamEntity.fromSqlite(json.decode(row['second_team']) as Map<String, dynamic>)
          : TeamEntity.empty(''),
      scores: scores..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
      ended: row['ended'] == 1,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
      endedAt: row['ended_at'] != null ? DateTime.parse(row['ended_at'] as String) : null,
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
      maxScore: data['max_score'] as int,
      ended: data['ended'] as bool,
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
      endedAt: data['ended_at'] != null ? DateTime.parse(data['ended_at'] as String) : null,
    );
  }

  int get firstTeamScore => scores.where((score) => score.teamId == firstTeam.id && !score.reversed).length;

  int get secondTeamScore => scores.where((score) => score.teamId == secondTeam.id && !score.reversed).length;

  bool get isByOne => firstTeamScore == maxScore - 1 || secondTeamScore == maxScore - 1;

  bool get isTiedWhenByOne => firstTeamScore == secondTeamScore && isByOne;

  bool get firstTeamWon => firstTeamScore == maxScore;

  bool get secondTeamWon => secondTeamScore == maxScore;

  bool get isEmpty => id == -1;

  bool get isNotEmpty => !isEmpty;

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
      maxScore: 0,
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }
}
