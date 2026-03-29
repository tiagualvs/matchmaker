import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_widget.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferencesService.create(
    encoders: {
      PlayerEntity.encoder(),
      EventEntity.encoder(),
    },
  );

  Injector.instance.batch((i) {
    i.lazySet<SharedPreferencesService>(() => prefs);
  });

  runApp(const AppWidget());
}
