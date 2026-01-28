import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
abstract class EventEntity with _$EventEntity {
  const EventEntity._();

  const factory EventEntity({
    required int id,
    required String name,
    @Default([]) List<TeamEntity> teams,
    @Default([]) List<MatchEntity> matches,
    @Default([]) List<int> queue,
    @JsonKey(name: 'max_score') @Default(12) int maxScore,
    @JsonKey(name: 'max_player_per_team') @Default(4) int maxPlayerPerTeam,
    @Default(false) bool ended,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
  }) = _EventEntity;

  factory EventEntity.fromJson(Map<String, dynamic> json) => _$EventEntityFromJson(json);

  factory EventEntity.fromSqlite(Map<String, dynamic> row) {
    final teams = List<TeamEntity>.from(
      row['teams'] != null ? (json.decode(row['teams']) as List).map((team) => TeamEntity.fromSqlite(team)) : [],
    );

    final matches = List<MatchEntity>.from(
      row['matches'] != null
          ? (json.decode(row['matches']) as List).map(
              (match) => MatchEntity.fromSqlite(match).copyWith(
                firstTeam: teams.firstWhere((team) => team.id == match['first_team_id']),
                secondTeam: teams.firstWhere((team) => team.id == match['second_team_id']),
              ),
            )
          : [],
    )..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final queue = List<int>.from(
      row['queue'] != null ? (json.decode(row['queue']) as List).map((id) => int.parse(id)) : [],
    );

    return EventEntity(
      id: row['id'] as int,
      name: row['name'] as String,
      maxScore: row['max_score'] as int,
      maxPlayerPerTeam: row['max_player_per_team'] as int,
      teams: teams,
      matches: matches,
      queue: queue,
      ended: row['ended'] == 1,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
      endedAt: row['ended_at'] != null ? DateTime.parse(row['ended_at'] as String) : null,
    );
  }

  factory EventEntity.fromSupabase(Map<String, dynamic> data) {
    final teams = List<TeamEntity>.from(
      (data['teams'] as List?)?.map((teamData) => TeamEntity.fromSupabase(teamData)) ?? [],
    );

    final matches = List<MatchEntity>.from(
      (data['matches'] as List?)?.map((matchData) {
            return MatchEntity.fromSupabase(matchData).copyWith(
              firstTeam: teams.firstWhere((team) => team.id == matchData['first_team_id']),
              secondTeam: teams.firstWhere((team) => team.id == matchData['second_team_id']),
            );
          }) ??
          [],
    )..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return EventEntity(
      id: data['id'] as int,
      name: data['name'] as String,
      maxScore: data['max_score'] as int,
      maxPlayerPerTeam: data['max_player_per_team'] as int,
      teams: teams,
      matches: matches,
      ended: data['ended'] as bool,
      queue: (data['queue'] as List).map((id) => int.parse(id)).toList(),
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
      endedAt: data['ended_at'] != null ? DateTime.parse(data['ended_at'] as String) : null,
    );
  }

  MatchEntity? get currentMatch {
    if (matches.isEmpty) return null;

    return matches.first;
  }

  bool get isEmpty => id.isNegative;

  bool get isNotEmpty => !isEmpty;

  factory EventEntity.empty() {
    return EventEntity(
      id: -1,
      name: '',
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }
}
