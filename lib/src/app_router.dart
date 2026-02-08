import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/go_router_state_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/presentation/controllers/create_event_controller.dart';
import 'package:matchmaker/src/presentation/controllers/event_controller.dart';
import 'package:matchmaker/src/presentation/controllers/event_settings_controller.dart';
import 'package:matchmaker/src/presentation/controllers/events_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_history_controller.dart';
import 'package:matchmaker/src/presentation/controllers/team_add_controller.dart';
import 'package:matchmaker/src/presentation/controllers/teams_controller.dart';
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
            page: ChangeNotifierProvider<EventsController>(
              create: (context) => EventsController(context.read())..getEventsList(onError: SnackBars.error),
              child: const EventsPage(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/events/:eventId',
        name: 'event',
        pageBuilder: (context, state) {
          return defaultTransition(
            key: state.pageKey,
            page: ChangeNotifierProvider<EventController>(
              create: (ctx) => EventController(ctx.read(), ctx.read())..loadDependencies(state.getPathParam('eventId')),
              child: const EventPage(),
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
            page: ChangeNotifierProvider<EventSettingsController>(
              create: (ctx) =>
                  EventSettingsController(ctx.read(), ctx.read())..loadDependencies(state.getPathParam('eventId')),
              child: const EventSettingsPage(),
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
            page: ChangeNotifierProvider<TeamsController>(
              create: (ctx) =>
                  TeamsController(ctx.read(), ctx.read(), ctx.read())..loadDependencies(state.getPathParam('eventId')),
              child: const TeamsPage(),
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
            page: ChangeNotifierProvider<TeamAddController>(
              create: (ctx) =>
                  TeamAddController(ctx.read(), ctx.read(), ctx.read())
                    ..loadDependencies(state.getPathParam('eventId')),
              child: const TeamAddPage(),
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
            page: ChangeNotifierProvider<CreateEventController>(
              create: (context) => CreateEventController(context.read(), context.read()),
              child: const CreateEventPage(),
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
            page: ChangeNotifierProvider<MatchController>(
              create: (ctx) => MatchController(ctx.read(), ctx.read())..loadDependencies(state.getPathParam('matchId')),
              child: const MatchPage(),
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
            page: ChangeNotifierProvider<MatchHistoryController>(
              create: (ctx) => MatchHistoryController(ctx.read())..loadDependencies(state.getPathParam('eventId')),
              child: const MatchHistoryPage(),
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
