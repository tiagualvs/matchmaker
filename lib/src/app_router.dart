import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  static final GoRouter config = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Events.path,
    routes: [
      GoRoute(
        path: Events.path,
        name: Events.name,
        pageBuilder: (context, state) {
          return transition(state.pageKey, const Events());
        },
      ),
      GoRoute(
        path: Event.path,
        name: Event.name,
        pageBuilder: (context, state) {
          return transition(
            state.pageKey,
            Event(eventId: state.get('eventId')),
          );
        },
      ),
      GoRoute(
        path: EventSettings.path,
        name: EventSettings.name,
        pageBuilder: (context, state) {
          return transition(
            state.pageKey,
            EventSettings(eventId: state.get('eventId')),
          );
        },
      ),
      GoRoute(
        path: Teams.path,
        name: Teams.name,
        pageBuilder: (context, state) {
          return transition(
            state.pageKey,
            Teams(eventId: state.get('eventId')),
          );
        },
      ),
      GoRoute(
        path: AddPlayer.path,
        name: AddPlayer.name,
        pageBuilder: (context, state) {
          return transition(
            state.pageKey,
            AddPlayer(eventId: state.get('eventId')),
          );
        },
      ),
      GoRoute(
        path: Match.path,
        name: Match.name,
        pageBuilder: (context, state) {
          return transition(
            state.pageKey,
            Match(eventId: state.get('eventId'), matchId: state.get('matchId')),
          );
        },
      ),
      GoRoute(
        path: MatchHistory.path,
        name: MatchHistory.name,
        pageBuilder: (context, state) {
          return transition(
            state.pageKey,
            MatchHistory(eventId: state.get('eventId')),
          );
        },
      ),
      GoRoute(
        path: CreateEvent.path,
        name: CreateEvent.name,
        pageBuilder: (context, state) {
          return transition(
            state.pageKey,
            const CreateEvent(),
          );
        },
      ),
    ],
  );

  static Page transition(LocalKey key, Widget page) {
    return CustomTransitionPage(
      key: key,
      child: page,
      reverseTransitionDuration: const Duration(milliseconds: 350),
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

extension on GoRouterState {
  String get(String key) => pathParameters[key] ?? '';
}
