import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/presentation/controllers/events_controller.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<EventsController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      await controller.getEventsList(onError: SnackBars.error);
    });

    return Consumer<EventsController>(
      builder: (context, controller, _) {
        final loading = controller.loading;
        final events = controller.events;

        return FloatingActionButtonMenu(
          menus: [
            FloatingActionButtonMenuItem(
              icon: const Icon(Symbols.add_rounded),
              label: const Text('Partida avulsa'),
              onPressed: () async {
                await context.pushNamed(
                  'match',
                  pathParameters: {
                    'matchId': '-99',
                  },
                );

                await WakelockPlus.disable();

                await SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
              },
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
                    trailing: event.ended ? null : const PulseAnimation(runningColor: Colors.green),
                  );
                },
              ),
            },
          ),
        );
      },
    );
  }
}

class PulseAnimation extends StatefulWidget {
  const PulseAnimation({
    super.key,
    this.runningColor = Colors.red,
    this.stopedColor = Colors.grey,
    this.running = true,
    this.duration = const Duration(milliseconds: 300),
  });

  final Color runningColor;
  final Color stopedColor;
  final Duration duration;
  final bool running;

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  late final forward = Tween<double>(
    begin: 1.0,
    end: 0.5,
  ).animate(controller);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.running) {
        await controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: forward, curve: Curves.easeInOut),
      alignment: .center,
      child: FadeTransition(
        opacity: CurvedAnimation(parent: forward, curve: Curves.easeInOut),
        child: Icon(
          Icons.circle,
          color: widget.running ? widget.runningColor : widget.stopedColor,
          size: 16.0,
        ),
      ),
    );
  }
}
