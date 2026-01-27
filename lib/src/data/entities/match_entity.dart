import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/v7.dart';

part 'match_entity.freezed.dart';
part 'match_entity.g.dart';

@freezed
abstract class MatchEntity with _$MatchEntity {
  const MatchEntity._();

  const factory MatchEntity({
    required String id,
    @JsonKey(name: 'event_id') required String eventId,
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

  factory MatchEntity.fromSqlite(Row row) {
    return MatchEntity(
      id: row['id'] as String,
      eventId: row['event_id'] as String,
      name: row['name'] as String,
      firstTeam: TeamEntity(
        id: row['first_team_id'] as String,
        eventId: row['first_team_event_id'] as String,
        name: row['first_team_name'] as String,
        players: [],
        createdAt: DateTime.parse(row['first_team_created_at'] as String),
        updatedAt: DateTime.parse(row['first_team_updated_at'] as String),
      ),
      secondTeam: TeamEntity(
        id: row['second_team_id'] as String,
        eventId: row['second_team_event_id'] as String,
        name: row['second_team_name'] as String,
        players: [],
        createdAt: DateTime.parse(row['second_team_created_at'] as String),
        updatedAt: DateTime.parse(row['second_team_updated_at'] as String),
      ),
      maxScore: row['max_score'] as int,
      ended: row['ended'] as int == 1,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
      endedAt: row['ended_at'] != null ? DateTime.parse(row['ended_at'] as String) : null,
    );
  }

  int get firstTeamScore => scores.where((score) => score.teamId == firstTeam.id && !score.reversed).length;

  int get secondTeamScore => scores.where((score) => score.teamId == secondTeam.id && !score.reversed).length;

  bool get isByOne => firstTeamScore == maxScore - 1 || secondTeamScore == maxScore - 1;

  bool get isTiedWhenByOne => firstTeamScore == secondTeamScore && isByOne;

  bool get firstTeamWon => firstTeamScore == maxScore;

  bool get secondTeamWon => secondTeamScore == maxScore;

  bool get isEmpty => id.isEmpty;

  bool get isNotEmpty => !isEmpty;

  ScoreEntity get lastScore {
    final realScores = scores.where((score) => !score.reversed).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    if (realScores.isEmpty) return ScoreEntity.empty();
    return realScores.first;
  }

  factory MatchEntity.empty() {
    return MatchEntity(
      id: '',
      eventId: '',
      name: '',
      firstTeam: TeamEntity.empty(),
      secondTeam: TeamEntity.empty(),
      maxScore: 0,
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }

  factory MatchEntity.create({
    required String eventId,
    required String name,
    required TeamEntity firstTeam,
    required TeamEntity secondTeam,
    required int maxScore,
  }) {
    return MatchEntity(
      id: const UuidV7().generate(),
      eventId: eventId,
      name: name,
      firstTeam: firstTeam,
      secondTeam: secondTeam,
      maxScore: maxScore,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
