import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/presentation/ui/widgets/event_settings_dialog.dart';

import 'events_settings_view_model.dart';

class EventsSettingsView extends EventsSettingsViewModel {
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
          onChange: (event) => this.event = event,
          onSave: (_) => save(
            onSuccess: () => context.pop(),
            onError: SnackBars.error,
          ),
        ),
      },
    );
  }
}
