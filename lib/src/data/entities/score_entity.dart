import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_entity.freezed.dart';
part 'score_entity.g.dart';

@freezed
abstract class ScoreEntity with _$ScoreEntity {
  const ScoreEntity._();

  const factory ScoreEntity({
    required int id,
    @JsonKey(name: 'match_id') required int matchId,
    @JsonKey(name: 'team_id') required int teamId,
    @Default(false) bool reversed,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ScoreEntity;

  factory ScoreEntity.fromJson(Map<String, dynamic> json) => _$ScoreEntityFromJson(json);

  factory ScoreEntity.fromSupabase(Map<String, dynamic> data) {
    return ScoreEntity(
      id: data['id'] as int,
      matchId: data['match_id'] as int,
      teamId: data['team_id'] as int,
      reversed: data['reversed'] as bool,
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
    );
  }

  bool get isEmpty => id == -1;

  bool get isNotEmpty => !isEmpty;

  factory ScoreEntity.empty() {
    return ScoreEntity(
      id: -1,
      matchId: -1,
      teamId: -1,
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }
}
