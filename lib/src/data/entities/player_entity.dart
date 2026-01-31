import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/services/database/database.dart';

part 'player_entity.freezed.dart';
part 'player_entity.g.dart';

@JsonEnum(alwaysCreate: true)
enum PlayerGender {
  male('male'),
  female('female'),
  unknown('unknown')
  ;

  final String value;

  const PlayerGender(this.value);

  static PlayerGender fromValue(String value) {
    return switch (value) {
      'male' || 'h' || 'H' => PlayerGender.male,
      'female' || 'm' || 'M' => PlayerGender.female,
      _ => PlayerGender.unknown,
    };
  }
}

enum PlayerLevel {
  basic('basic'),
  intermediate('intermediate'),
  advanced('advanced')
  ;

  final String value;

  const PlayerLevel(this.value);

  static PlayerLevel fromValue(String value) {
    return switch (value) {
      'basic' => PlayerLevel.basic,
      'intermediate' => PlayerLevel.intermediate,
      'advanced' => PlayerLevel.advanced,
      _ => PlayerLevel.basic,
    };
  }
}

@freezed
abstract class PlayerEntity with _$PlayerEntity {
  const PlayerEntity._();

  const factory PlayerEntity({
    required int id,
    required String name,
    @Default(PlayerGender.unknown) PlayerGender gender,
    @Default(PlayerLevel.basic) PlayerLevel level,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlayerEntity;

  factory PlayerEntity.fromJson(Map<String, dynamic> json) => _$PlayerEntityFromJson(json);

  factory PlayerEntity.fromDrift(PlayerData data) {
    return PlayerEntity(
      id: data.id,
      name: data.name,
      gender: PlayerGender.fromValue(data.gender),
      level: PlayerLevel.fromValue(data.level),
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  factory PlayerEntity.fromSupabase(Map<String, dynamic> data) {
    return PlayerEntity(
      id: data['id'] as int,
      name: data['name'] as String,
      gender: PlayerGender.fromValue(data['gender'] as String),
      level: PlayerLevel.fromValue(data['level'] as String),
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
    );
  }

  factory PlayerEntity.empty(String name, PlayerGender gender) {
    return PlayerEntity(
      id: -1,
      name: name,
      gender: gender,
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }

  factory PlayerEntity.joker(int index, PlayerGender gender) {
    return PlayerEntity(
      id: -99,
      name: switch (gender) {
        PlayerGender.male => 'Jogador Coringa',
        PlayerGender.female => 'Jogadora Coringa',
        _ => 'Jogador Coringa',
      },
      gender: gender,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  bool get isJoker => id == -99;

  bool get isWoman => gender == PlayerGender.female;

  bool get isMan => gender == PlayerGender.male;

  bool get isUnknown => gender == PlayerGender.unknown;
}
