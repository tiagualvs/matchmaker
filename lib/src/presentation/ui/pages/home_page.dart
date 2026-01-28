import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/presentation/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});

  final HomeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController get controller => widget.controller;

  List<EventEntity> get events => controller.events;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      await controller.getEventsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Eventos'),
          ),
          body: switch (events.isEmpty) {
            true => Column(
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
                  subtitle: switch (currentMatch != null) {
                    true => Text('${currentMatch?.details}'),
                    false => const Text('Nenhum jogo em andamento'),
                  },
                  trailing: PulseAnimation(
                    runningColor: Colors.green,
                    running: currentMatch?.ended == false,
                  ),
                );
              },
            ),
          },
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final hasCreated = await context.pushNamed<bool>('createEvent');

              if (hasCreated ?? false) {
                await controller.getEventsList();
              }
            },
            child: const Icon(Icons.add_rounded),
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
