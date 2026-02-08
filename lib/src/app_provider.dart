import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/repositories/events/events_local_repository.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_local_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_local_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_local_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_local_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';
import 'package:matchmaker/src/data/services/database/app_database.dart';
import 'package:matchmaker/src/presentation/controllers/event_settings_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_history_controller.dart';
import 'package:matchmaker/src/presentation/controllers/team_add_controller.dart';
import 'package:matchmaker/src/presentation/controllers/teams_controller.dart';
import 'package:provider/provider.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child}) : _testing = false;

  const AppProvider.testing({super.key, required this.child}) : _testing = true;

  final bool _testing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (ctx) => _testing ? AppDatabase.testing() : AppDatabase(),
        ),
        Provider<EventsRepository>(
          create: (ctx) => EventsLocalRepository(ctx.read()),
        ),
        Provider<TeamsRepository>(
          create: (ctx) => TeamsLocalRepository(ctx.read()),
        ),
        Provider<MatchesRepository>(
          create: (ctx) => MatchesLocalRepository(ctx.read()),
        ),
        Provider<ScoresRepository>(
          create: (ctx) => ScoresLocalRepository(ctx.read()),
        ),
        Provider<PlayersRepository>(
          create: (ctx) => PlayersLocalRepository(ctx.read()),
        ),
        ListenableProvider<MatchController>(
          create: (ctx) => MatchController(ctx.read(), ctx.read()),
        ),
        ListenableProvider<MatchHistoryController>(
          create: (ctx) => MatchHistoryController(ctx.read()),
        ),
        ListenableProvider<EventSettingsController>(
          create: (ctx) => EventSettingsController(ctx.read(), ctx.read()),
        ),
        ListenableProvider<TeamsController>(
          create: (ctx) => TeamsController(ctx.read(), ctx.read(), ctx.read()),
        ),
        ListenableProvider<TeamAddController>(
          create: (ctx) => TeamAddController(ctx.read(), ctx.read(), ctx.read()),
        ),
      ],
      child: child,
    );
  }
}
