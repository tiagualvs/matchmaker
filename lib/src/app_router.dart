import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/go_router_state_ext.dart';
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

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Events.path,
    routes: [
      GoRoute(
        path: Events.path,
        name: Events.name,
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: const Events(),
          );
        },
      ),
      GoRoute(
        path: Event.path,
        name: Event.name,
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: Event(eventId: state.getPathParam('eventId')),
          );
        },
      ),
      GoRoute(
        path: EventSettings.path,
        name: EventSettings.name,
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: EventSettings(eventId: state.getPathParam('eventId')),
          );
        },
      ),
      GoRoute(
        path: Teams.path,
        name: Teams.name,
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: Teams(eventId: state.getPathParam('eventId')),
          );
        },
      ),
      GoRoute(
        path: AddPlayer.path,
        name: AddPlayer.name,
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: AddPlayer(eventId: state.getPathParam('eventId')),
          );
        },
      ),
      GoRoute(
        path: CreateEvent.path,
        name: CreateEvent.name,
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: const CreateEvent(),
          );
        },
      ),
      GoRoute(
        path: Match.path,
        name: Match.name,
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: Match(
              matchId: state.getPathParam('matchId'),
            ),
          );
        },
      ),
      GoRoute(
        path: MatchHistory.path,
        name: MatchHistory.name,
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: MatchHistory(
              eventId: state.getPathParam('eventId'),
            ),
          );
        },
      ),
    ],
  );

  static Page defaultTransition({
    required LocalKey key,
    required Widget page,
  }) {
    return CustomTransitionPage(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
