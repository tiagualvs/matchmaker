import 'dart:convert';

import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExt on SharedPreferences {
  List<EventEntity> getEventsList() {
    return getKeys()
        .where((key) => key.startsWith('event_'))
        .map((key) => getString(key)!)
        .map((source) => Map<String, dynamic>.from(json.decode(source)))
        .map(EventEntity.fromJson)
        .toList();
  }

  EventEntity? getEvent(String id) {
    final source = getString('event_$id');
    if (source == null) return null;
    return EventEntity.fromJson(Map<String, dynamic>.from(json.decode(source)));
  }

  Future<bool> setEvent(EventEntity event) async {
    return await setString(event.storageKey, json.encode(event.toJson()));
  }

  Future<bool> setPlayer(PlayerEntity player) async {
    if (player.isJoker) return false;
    return await setString(player.storageKey, json.encode(player.toJson()));
  }
}
