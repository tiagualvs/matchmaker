import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/presentation/controllers/event_settings_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/event_settings_dialog.dart';
import 'package:provider/provider.dart';

class EventSettingsPage extends StatelessWidget {
  const EventSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EventSettingsController>();

    final loading = controller.loading;

    final event = controller.event;

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
