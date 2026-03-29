import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/common/shared/id.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

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
  basic('basic', '⭐'),
  intermediate('intermediate', '⭐⭐'),
  advanced('advanced', '⭐⭐⭐')
  ;

  final String value;
  final String emoji;

  const PlayerLevel(this.value, this.emoji);

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
    required String id,
    required String name,
    @Default(PlayerGender.unknown) PlayerGender gender,
    @Default(PlayerLevel.basic) PlayerLevel level,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlayerEntity;

  factory PlayerEntity.fromJson(Map<String, dynamic> json) =>
      _$PlayerEntityFromJson(json);

  factory PlayerEntity.create({
    required String name,
    required PlayerGender gender,
    required PlayerLevel level,
  }) {
    return PlayerEntity(
      id: Id.generate(),
      name: name,
      gender: gender,
      level: level,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  factory PlayerEntity.empty(String name, PlayerGender gender) {
    return PlayerEntity(
      id: Id.min(),
      name: name,
      gender: gender,
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }

  factory PlayerEntity.joker(int index, PlayerGender gender) {
    return PlayerEntity(
      id: Id.max(),
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

  bool get isEmpty => id == Id.min();

  bool get isNotEmpty => !isEmpty;

  bool get isJoker => id == Id.max();

  bool get isWoman => gender == PlayerGender.female;

  bool get isMan => gender == PlayerGender.male;

  bool get isUnknown => gender == PlayerGender.unknown;

  static SharedPreferencesEncoder<PlayerEntity> encoder() => _PlayerEncoder();
}

class _PlayerEncoder extends SharedPreferencesEncoder<PlayerEntity> {
  @override
  String identifier(PlayerEntity value) => value.id;

  @override
  PlayerEntity? decode(String source) {
    return PlayerEntity.fromJson(json.decode(source));
  }

  @override
  String encode(PlayerEntity value) {
    return json.encode(value.toJson());
  }
}
