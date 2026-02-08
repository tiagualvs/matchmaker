// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:matchmaker/src/app_widget.dart';
// import 'package:matchmaker/src/common/shared/result.dart';
// import 'package:matchmaker/src/data/entities/event_entity.dart';
// import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:provider/provider.dart';

// import 'extensions/common_finders_ext.dart';

// class EventsRepositoryMock extends Mock implements EventsRepository {}

// final eventsList = List.generate(
//   5,
//   (index) => EventEntity(
//     id: index,
//     name: 'Event ${index + 1}',
//     ended: false,
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   ),
// );

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   late final EventsRepository repository;

//   setUpAll(() {
//     repository = EventsRepositoryMock();
//   });

//   testWidgets(
//     'Should show a loading and after an empty state!',
//     (tester) async {
//       when(() => repository.findMany()).thenAnswer((_) async {
//         return Future<Result<List<EventEntity>>>.delayed(
//           const Duration(seconds: 3),
//           () => const Result.value([]),
//         );
//       });

//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [Provider.value(value: repository)],
//           child: const AppWidget(),
//         ),
//       );

//       await tester.pump();

//       final appBar = find.appBarWithTextTitle('Matchmaker');

//       expect(appBar, findsOneWidget);

//       final loadingState = find.byType(CircularProgressIndicator);

//       expect(loadingState, findsOneWidget);

//       final fabMenu = find.fabWithAnimatedIconData(AnimatedIcons.menu_close);

//       expect(fabMenu, findsOneWidget);

//       await tester.tap(fabMenu);

//       await tester.pumpAndSettle();

//       expect(find.text('Partida avulsa'), findsOneWidget);

//       expect(find.text('Criar novo evento'), findsOneWidget);

//       await tester.tap(fabMenu);

//       await tester.pumpAndSettle();

//       expect(loadingState, findsNothing);

//       final emptyState = find.text('Nenhum evento encontrado');

//       expect(emptyState, findsOneWidget);
//     },
//   );

//   testWidgets(
//     'Should show a loading and after a loaded state with 5 events!',
//     (tester) async {
//       when(() => repository.findMany()).thenAnswer((_) async {
//         return Future<Result<List<EventEntity>>>.delayed(
//           const Duration(seconds: 3),
//           () => Result.value(eventsList),
//         );
//       });

//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [Provider.value(value: repository)],
//           child: const AppWidget(),
//         ),
//       );

//       await tester.pump();

//       final appBar = find.appBarWithTextTitle('Matchmaker');

//       expect(appBar, findsOneWidget);

//       final loadingState = find.byType(CircularProgressIndicator);

//       expect(loadingState, findsOneWidget);

//       final fabMenu = find.fabWithAnimatedIconData(AnimatedIcons.menu_close);

//       expect(fabMenu, findsOneWidget);

//       await tester.tap(fabMenu);

//       await tester.pumpAndSettle();

//       expect(find.text('Partida avulsa'), findsOneWidget);

//       expect(find.text('Criar novo evento'), findsOneWidget);

//       await tester.tap(fabMenu);

//       await tester.pumpAndSettle();

//       expect(loadingState, findsNothing);

//       final loadedState = find.byType(ListView);

//       expect(loadedState, findsOneWidget);

//       await tester.drag(loadedState, const Offset(0, -100));

//       await tester.pumpAndSettle();

//       for (final event in eventsList) {
//         expect(find.listTileWithTextTitle(event.name), findsOneWidget);
//       }
//     },
//   );
// }
