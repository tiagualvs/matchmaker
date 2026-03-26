import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/presentation/ui/widgets/event_settings_dialog.dart';

import 'event_settings_view_model.dart';

class EventSettingsView extends EventSettingsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: Navigator.of(context).pop,
        ),
        title: Text(L10n.of(context).settings),
      ),
      body: switch (loading) {
        true => const Center(child: CircularProgressIndicator()),
        false => EventSettingsDialog(
          event: event,
          hideAppBar: true,
          onChange: (event) => this.event = event,
          onSave: (_) => save(
            onSuccess: Navigator.of(context).pop,
            onError: SnackBars.error,
          ),
        ),
      },
    );
  }
}
