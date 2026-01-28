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
    @JsonKey(name: 'balanced_by_gender') @Default(true) bool balancedByGender,
    @JsonKey(name: 'balanced_by_level') @Default(true) bool balancedByLevel,
    @JsonKey(name: 'max_wins_in_a_row') @Default(0) int maxWinsInARow,
    @JsonKey(name: 'half_score_to_eliminate') @Default(false) bool halfScoreToEliminate,
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
      row['queue'] != null
          ? (row['queue'] as String).split(',').where((id) => id.isNotEmpty).map((id) => int.parse(id))
          : [],
    );

    return EventEntity(
      id: row['id'] as int,
      name: row['name'] as String,
      maxScore: row['max_score'] as int,
      maxPlayerPerTeam: row['max_player_per_team'] as int,
      balancedByGender: row['balanced_by_gender'] == 1,
      balancedByLevel: row['balanced_by_level'] == 1,
      maxWinsInARow: row['max_wins_in_a_row'] as int,
      teams: teams,
      matches: matches,
      queue: queue,
      halfScoreToEliminate: row['half_score_to_eliminate'] == 1,
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

  bool teamHasMaxWinsInARow(int teamId) {
    if (maxWinsInARow == 0) return false;

    final ids = endedMatches.map((match) => match.winner?.id ?? -1).where((id) => !id.isNegative);

    if (ids.length < maxWinsInARow) return false;

    final range = ids.take(maxWinsInARow);

    return range.every((id) => id == teamId);
  }

  List<MatchEntity> get endedMatches => matches.where((match) => match.ended).toList();

  List<MatchEntity> get notEndedMatches => matches.where((match) => !match.ended).toList();

  MatchEntity? get currentMatch {
    if (notEndedMatches.isEmpty) return null;

    return notEndedMatches.first;
  }

  MatchEntity? get lastEndedMatch {
    if (endedMatches.isEmpty) return null;

    return endedMatches.first;
  }

  int teamWins(int teamId) {
    return endedMatches.where((match) => match.winner?.id == teamId).length;
  }

  int teamLosses(int teamId) {
    return endedMatches.where((match) => match.loser?.id == teamId).length;
  }

  List<TeamEntity> get sortedTeams {
    return List.from(teams)..sort((a, b) {
      final aWins = teamWins(a.id);
      final aLosses = teamLosses(a.id);
      final bWins = teamWins(b.id);
      final bLosses = teamLosses(b.id);

      return bWins.compareTo(aWins) == 0 ? aLosses.compareTo(bLosses) : bWins.compareTo(aWins);
    });
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
