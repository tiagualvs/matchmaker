import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

import 'match_history.dart';

abstract class MatchHistoryViewModel extends State<MatchHistory> {
  SharedPreferencesService get prefs => Injector.instance.get();

  final bool _loading = false;

  bool get loading => _loading;

  late final EventEntity _event =
      prefs.find<EventEntity>((e) => e.id == widget.eventId) ??
      EventEntity.empty();

  EventEntity get event => _event;

  List<MatchEntity> get matches => _event.endedMatches;
}
