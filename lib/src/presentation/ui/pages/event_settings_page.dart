import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/shared/controller.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/presentation/controllers/event_settings_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/event_settings_dialog.dart';

class EventSettingsPage extends StatefulWidget {
  const EventSettingsPage({super.key, required this.eventId, required this.controller});

  final int eventId;
  final EventSettingsController controller;

  @override
  State<EventSettingsPage> createState() => _EventSettingsPageState();
}

class _EventSettingsPageState extends State<EventSettingsPage> with ControllerMixin {
  EventSettingsController get controller => widget.controller;

  bool get loading => controller.loading;

  EventEntity get event => controller.event;

  @override
  Controller get bind => controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.loadDependencies(widget.eventId, onError: SnackBars.error);
    });
  }

  @override
  void dispose() {
    controller.resetController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Configurações'),
      ),
      body: switch (loading) {
        true => const Center(child: CircularProgressIndicator()),
        false => EventSettingsDialog(
          event: event,
          hideAppBar: true,
          onChange: controller.updateEvent,
          onSave: (_) => controller.save(
            onSuccess: () => context.pop(),
            onError: SnackBars.error,
          ),
        ),
      },
    );
  }
}
