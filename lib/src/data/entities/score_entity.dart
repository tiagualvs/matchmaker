import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/common/shared/id.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';

part 'score_entity.freezed.dart';
part 'score_entity.g.dart';

@freezed
abstract class ScoreEntity with _$ScoreEntity {
  const ScoreEntity._();

  const factory ScoreEntity({
    required String id,
    required String matchId,
    required String teamId,
    @Default(false) bool reversed,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ScoreEntity;

  factory ScoreEntity.fromJson(Map<String, dynamic> json) =>
      _$ScoreEntityFromJson(json);

  factory ScoreEntity.create({
    required String matchId,
    required String teamId,
  }) {
    return ScoreEntity(
      id: Id.generate(),
      matchId: matchId,
      teamId: teamId,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  factory ScoreEntity.empty() {
    return ScoreEntity(
      id: Id.min(),
      matchId: Id.min(),
      teamId: Id.min(),
      createdAt: Timestamp.min(),
      updatedAt: Timestamp.min(),
    );
  }

  bool get isEmpty => id == Id.min();

  bool get isNotEmpty => !isEmpty;
}
