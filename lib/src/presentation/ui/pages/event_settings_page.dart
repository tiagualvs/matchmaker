import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/presentation/controllers/event_settings_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/event_settings_dialog.dart';
import 'package:provider/provider.dart';

class EventSettingsPage extends StatelessWidget {
  const EventSettingsPage({super.key, required this.eventId});

  final int eventId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<EventSettingsController>()..resetController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.loadDependencies(eventId, onError: SnackBars.error);
    });

    return Consumer<EventSettingsController>(
      builder: (context, controller, _) {
        final loading = controller.loading;

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
              event: controller.event,
              hideAppBar: true,
              onChange: (value) => controller.setState(() {
                controller.event = value;
              }),
              onSave: (_) => controller.save(
                onSuccess: () => context.pop(),
                onError: SnackBars.error,
              ),
            ),
          },
        );
      },
    );
  }
}
