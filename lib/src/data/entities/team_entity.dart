import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';

part 'team_entity.freezed.dart';
part 'team_entity.g.dart';

@freezed
abstract class TeamEntity with _$TeamEntity {
  const TeamEntity._();

  const factory TeamEntity({
    required int id,
    @JsonKey(name: 'event_id') required int eventId,
    required String name,
    required List<PlayerEntity> players,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _TeamEntity;

  factory TeamEntity.fromJson(Map<String, dynamic> json) => _$TeamEntityFromJson(json);

  factory TeamEntity.fromSupabase(Map<String, dynamic> data) {
    return TeamEntity(
      id: data['id'] as int,
      eventId: data['event_id'] as int,
      name: data['name'] as String,
      players: List.from(
        (data['players'] as List?)?.map((playerData) => PlayerEntity.fromSupabase(playerData)) ?? [],
      ),
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
    );
  }

  factory TeamEntity.empty(String name) {
    return TeamEntity(
      id: -1,
      eventId: -1,
      name: name,
      players: [],
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }
}
