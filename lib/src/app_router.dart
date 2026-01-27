import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/presentation/ui/pages/create_event_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/event_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/home_page.dart';
import 'package:matchmaker/src/presentation/ui/pages/match_page.dart';
import 'package:provider/provider.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: HomePage(
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
              id: state.pathParameters['id'] ?? '',
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
              matchId: state.pathParameters['matchId'] ?? '',
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
