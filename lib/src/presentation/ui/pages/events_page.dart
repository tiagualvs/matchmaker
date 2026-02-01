import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/shared/controller.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/presentation/controllers/events_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/pulse_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key, required this.controller});

  final EventsController controller;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with ControllerMixin {
  EventsController get controller => widget.controller;

  bool get loading => controller.loading;

  List<EventEntity> get events => controller.events;

  @override
  Controller get bind => controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getEventsList(onError: SnackBars.error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButtonMenu(
      menus: [
        FloatingActionButtonMenuItem(
          icon: const Icon(Symbols.add_rounded),
          label: const Text('Partida avulsa'),
          onPressed: () => context.pushNamed(
            'match',
            pathParameters: {
              'matchId': '-99',
            },
          ),
        ),
        FloatingActionButtonMenuItem(
          icon: const Icon(Symbols.event_rounded),
          label: const Text('Criar novo evento'),
          onPressed: () async {
            await context.pushNamed<bool>('createEvent');

            await controller.getEventsList();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Matchmaker'),
        ),
        body: switch (loading) {
          true => const Center(child: CircularProgressIndicator()),
          false when events.isEmpty => Column(
            crossAxisAlignment: .stretch,
            mainAxisAlignment: .center,
            children: [
              const Icon(
                Icons.event,
                size: 92.0,
              ),
              Text(
                'Nenhum evento encontrado',
                textAlign: .center,
                style: context.textTheme.titleMedium,
              ),
            ],
          ),
          false => ListView.separated(
            separatorBuilder: (_, _) => const SizedBox(height: 16.0),
            padding: const .all(16.0),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final currentMatch = event.currentMatch;

              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: context.colorScheme.surfaceContainerHighest,
                  ),
                ),
                tileColor: context.colorScheme.onPrimary,
                onTap: () async {
                  await context.pushNamed(
                    'event',
                    pathParameters: {'id': event.id.toString()},
                  );

                  await controller.getEventsList();
                },
                title: Text(event.name),
                subtitle: switch (event.ended && event.endedAt != null) {
                  true => Text(
                    'Evento finalizado em ${DateFormat("dd 'de' MMM 'de' yyyy 'às' HH:mm").format(event.endedAt!)}',
                  ),
                  false => switch (currentMatch != null) {
                    true => Text('${currentMatch?.details}'),
                    false => const Text('Nenhum jogo em andamento'),
                  },
                },
                trailing: event.ended ? null : const PulseAnimationWidget(runningColor: Colors.green),
              );
            },
          ),
        },
      ),
    );
  }
}
