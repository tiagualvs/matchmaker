import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/add_player/add_player.dart';
import 'package:matchmaker/src/presentation/teams/teams.dart';

import 'presentation/create_event/create_event.dart';
import 'presentation/event/event.dart';
import 'presentation/event_settings/event_settings.dart';
import 'presentation/events/events.dart';
import 'presentation/match/match.dart';
import 'presentation/match_history/match_history.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      Events.path => pageBuilder(
        settings,
        const Events(),
      ),
      Event.path => pageBuilder(
        settings,
        Event(event: settings.arguments as EventEntity),
      ),
      EventSettings.path => pageBuilder(
        settings,
        EventSettings(event: settings.arguments as EventEntity),
      ),
      Teams.path => pageBuilder(
        settings,
        Teams(event: settings.arguments as EventEntity),
      ),
      AddPlayer.path => pageBuilder<TeamEntity>(
        settings,
        AddPlayer(event: settings.arguments as EventEntity),
      ),
      CreateEvent.path => pageBuilder(
        settings,
        const CreateEvent(),
      ),
      Match.path => pageBuilder(
        settings,
        Match(match: settings.arguments as MatchEntity?),
      ),
      MatchHistory.path => pageBuilder(
        settings,
        MatchHistory(event: settings.arguments as EventEntity),
      ),
      _ => pageBuilder(settings, const Scaffold()),
    };
  }

  static PageRoute pageBuilder<T>(RouteSettings settings, Widget page) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      pageBuilder: (context, _, _) {
        return page;
      },
    );
  }
}
