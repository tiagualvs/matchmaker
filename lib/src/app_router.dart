import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/presentation/ui/pages/create_event_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/event_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/event_settings_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/events_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/match_history_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/match_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/team_add_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/teams_page.dart';
import 'package:provider/provider.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'events',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: EventsPage(
              controller: context.read(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/events/:id',
        name: 'event',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: EventPage(
              id: int.parse(state.pathParameters['id'] ?? '-1'),
              controller: context.read(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/event-settings/:eventId',
        name: 'event-settings',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: EventSettingsPage(
              eventId: int.parse(state.pathParameters['eventId'] ?? '-1'),
              controller: context.read(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/teams/:eventId',
        name: 'teams',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: TeamsPage(
              eventId: int.parse(state.pathParameters['eventId'] ?? '-1'),
              controller: context.read(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/teams/:eventId/add',
        name: 'teamAdd',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: TeamAddPage(
              eventId: int.parse(state.pathParameters['eventId'] ?? '-1'),
              controller: context.read(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/create-event',
        name: 'createEvent',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: CreateEventPage(
              controller: context.read(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/matches/:matchId',
        name: 'match',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: MatchPage(
              matchId: int.parse(state.pathParameters['matchId'] ?? '-1'),
              controller: context.read(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/matche-history/:eventId',
        name: 'match-history',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: MatchHistoryPage(
              eventId: int.parse(state.pathParameters['eventId'] ?? '-1'),
              controller: context.read(),
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
