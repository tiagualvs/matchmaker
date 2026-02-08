import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/services/database/app_database.dart';

part 'score_entity.freezed.dart';
part 'score_entity.g.dart';

@freezed
abstract class ScoreEntity with _$ScoreEntity {
  const ScoreEntity._();

  const factory ScoreEntity({
    required int id,
    required int matchId,
    required int teamId,
    @Default(false) bool reversed,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ScoreEntity;

  factory ScoreEntity.fromJson(Map<String, dynamic> json) => _$ScoreEntityFromJson(json);

  factory ScoreEntity.fromDrift(ScoreData data) {
    return ScoreEntity(
      id: data.id,
      matchId: data.matchId,
      teamId: data.teamId,
      reversed: data.reversed,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
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
