import 'dart:core' hide Match;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/presentation/create_event/create_event.dart';
import 'package:matchmaker/src/presentation/event/event.dart';
import 'package:matchmaker/src/presentation/events/events_view_model.dart';
import 'package:matchmaker/src/presentation/match/match.dart';
import 'package:matchmaker/src/presentation/ui/widgets/pulse_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class EventsView extends EventsViewModel {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButtonMenu(
      menus: [
        FloatingActionButtonMenuItem(
          icon: const Icon(Symbols.add_rounded),
          label: Text(L10n.of(context).singleMatch),
          onPressed: () => Match.push(context),
        ),
        FloatingActionButtonMenuItem(
          icon: const Icon(Symbols.event_rounded),
          label: Text(L10n.of(context).createNewEvent),
          onPressed: () async {
            await CreateEvent.push(context);

            await getEventsList();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(L10n.of(context).appTitle),
        ),
        body: switch (loading) {
          true => const Center(child: CircularProgressIndicator()),
          false when events.isEmpty => Center(
            child: Column(
              crossAxisAlignment: .stretch,
              mainAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                const Icon(
                  Icons.event,
                  size: 92.0,
                ),
                Text(
                  L10n.of(context).noEventsFound,
                  textAlign: .center,
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
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
                  await Event.push(context, event);

                  await getEventsList();
                },
                title: Text(event.name),
                subtitle: switch (event.ended && event.endedAt != null) {
                  true => Text(
                    L10n.of(context).eventFinishedOn(
                      DateFormat("dd 'de' MMM 'de' yyyy 'às' HH:mm").format(event.endedAt!),
                    ),
                  ),
                  false => switch (currentMatch != null) {
                    true => Text('${currentMatch?.details}'),
                    false => Text(L10n.of(context).noGameInProgress),
                  },
                },
                trailing: event.ended
                    ? null
                    : const PulseAnimationWidget(runningColor: Colors.green),
              );
            },
          ),
        },
      ),
    );
  }
}
