import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/repositories/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/scores_repository.dart';
import 'package:matchmaker/src/presentation/controllers/create_event_controller.dart';
import 'package:matchmaker/src/presentation/controllers/event_controller.dart';
import 'package:matchmaker/src/presentation/controllers/home_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_history_controller.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventsRepository>(
          create: (ctx) => EventsRepositoryImp(Supabase.instance.client),
        ),
        Provider<MatchesRepository>(
          create: (ctx) => MatchesRepositoryImp(Supabase.instance.client),
        ),
        Provider<ScoresRepository>(
          create: (ctx) => ScoresRepositoryImp(Supabase.instance.client),
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
      ],
      child: child,
    );
  }
}
