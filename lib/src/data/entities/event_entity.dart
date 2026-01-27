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
