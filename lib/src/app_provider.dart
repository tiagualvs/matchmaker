import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_database.dart';
import 'package:matchmaker/src/data/repositories/events/events_local_repository.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_local_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_local_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_repository.dart';
import 'package:matchmaker/src/presentation/controllers/create_event_controller.dart';
import 'package:matchmaker/src/presentation/controllers/event_controller.dart';
import 'package:matchmaker/src/presentation/controllers/event_settings_controller.dart';
import 'package:matchmaker/src/presentation/controllers/home_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_history_controller.dart';
import 'package:provider/provider.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventsRepository>(
          create: (ctx) => EventsLocalRepository(AppDatabase.instance),
        ),
        Provider<MatchesRepository>(
          create: (ctx) => MatchesLocalRepository(AppDatabase.instance),
        ),
        Provider<ScoresRepository>(
          create: (ctx) => ScoresLocalRepository(AppDatabase.instance),
        ),
        InheritedProvider<HomeController>(
          create: (ctx) => HomeController(ctx.read()),
        ),
        InheritedProvider<EventController>(
          create: (ctx) => EventController(ctx.read(), ctx.read()),
        ),
        InheritedProvider<CreateEventController>(
          create: (ctx) => CreateEventController(ctx.read()),
        ),
        InheritedProvider<MatchController>(
          create: (ctx) => MatchController(ctx.read(), ctx.read()),
        ),
        InheritedProvider<MatchHistoryController>(
          create: (ctx) => MatchHistoryController(ctx.read()),
        ),
        InheritedProvider<EventSettingsController>(
          create: (ctx) => EventSettingsController(ctx.read(), ctx.read()),
        ),
      ],
      child: child,
    );
  }
}
