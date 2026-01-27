import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) => controller.getEventsList());
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Eventos'),
          ),
          body: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];

              return ListTile(
                onTap: () => context.pushNamed(
                  'event',
                  pathParameters: {'id': event.id},
                ),
                title: Text(event.name),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.pushNamed('createEvent'),
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }
}
