import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

class EventSettingsDialog extends StatefulWidget {
  const EventSettingsDialog({
    super.key,
    required this.event,
    this.hideAppBar = false,
    this.onSave,
    this.onChange,
  });

  final EventEntity event;
  final bool hideAppBar;
  final Future<void> Function(EventEntity event)? onSave;
  final void Function(EventEntity event)? onChange;

  @override
  State<EventSettingsDialog> createState() => _EventSettingsDialogState();
}

class _EventSettingsDialogState extends State<EventSettingsDialog> {
  late EventEntity event = widget.event;

  void handleEventChanges(EventEntity event) {
    setState(() {
      this.event = event;

      widget.onChange?.call(event);
    });
  }

  @override
  void didUpdateWidget(covariant EventSettingsDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.event != widget.event) {
      setState(() {
        event = widget.event;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: switch (widget.hideAppBar) {
        true => null,
        false => AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(L10n.of(context).settings),
        ),
      },
      body: SingleChildScrollView(
        padding: const .all(16.0),
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            Text(
              L10n.of(context).eventSettingsTitle(
                event.ended ? 'finished' : 'other',
              ),
              textAlign: .start,
              style: context.textTheme.titleMedium,
            ),
            TextFormField(
              initialValue: event.name,
              keyboardType: TextInputType.text,
              onChanged: (value) => handleEventChanges(
                event.copyWith(name: value),
              ),
              enabled: !event.ended,
              decoration: InputDecoration(
                hintText: L10n.of(context).nameLabel,
                labelText: L10n.of(context).eventNameLabel,
                floatingLabelBehavior: .always,
              ),
            ),
            TextFormField(
              initialValue: event.maxScore.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isEmpty) return;

                return handleEventChanges(
                  event.copyWith(maxScore: int.parse(value)),
                );
              },
              enabled: !event.ended,
              decoration: InputDecoration(
                hintText: L10n.of(context).quantityLabel,
                labelText: L10n.of(context).pointsToWinLabel,
                floatingLabelBehavior: .always,
              ),
            ),
            TextFormField(
              initialValue: event.maxPlayerPerTeam.toString(),
              keyboardType: TextInputType.number,
              enabled: event.teams.isEmpty && !event.ended,
              onChanged: (value) {
                if (value.isEmpty) return;

                return handleEventChanges(
                  event.copyWith(maxPlayerPerTeam: int.parse(value)),
                );
              },
              decoration: InputDecoration(
                hintText: L10n.of(context).quantityLabel,
                labelText: L10n.of(context).playersPerTeamLabel,
                floatingLabelBehavior: .always,
              ),
            ),
            TextFormField(
              initialValue: event.maxWinsInARow.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isEmpty) return;

                return handleEventChanges(
                  event.copyWith(maxWinsInARow: int.parse(value)),
                );
              },
              enabled: !event.ended,
              decoration: InputDecoration(
                hintText: L10n.of(context).quantityLabel,
                labelText: L10n.of(context).maxWinsInARowLabel,
                floatingLabelBehavior: .always,
              ),
            ),
            SwitchListTile(
              value: event.halfScoreToEliminate,
              contentPadding: .zero,
              materialTapTargetSize: .shrinkWrap,
              title: Text(L10n.of(context).eliminateAtHalf),
              subtitle: Text(
                L10n.of(context).eliminateAtHalfSubtitle(
                  (event.maxScore / 2).round(),
                ),
              ),
              onChanged: event.ended
                  ? null
                  : (value) {
                      return handleEventChanges(
                        event.copyWith(halfScoreToEliminate: value),
                      );
                    },
            ),
            SwitchListTile(
              value: event.balancedByGender,
              contentPadding: .zero,
              materialTapTargetSize: .shrinkWrap,
              title: Text(L10n.of(context).balanceByGender),
              subtitle: Text(
                L10n.of(context).balanceByGenderSubtitle,
              ),
              onChanged: event.teams.isEmpty && !event.ended
                  ? (value) {
                      return handleEventChanges(
                        event.copyWith(balancedByGender: value),
                      );
                    }
                  : null,
            ),
            SwitchListTile(
              value: event.balancedByLevel,
              contentPadding: .zero,
              materialTapTargetSize: .shrinkWrap,
              title: Text(L10n.of(context).balanceByLevel),
              subtitle: Text(
                L10n.of(context).balanceByLevelSubtitle,
              ),
              onChanged: event.teams.isEmpty && !event.ended
                  ? (value) {
                      return handleEventChanges(
                        event.copyWith(balancedByLevel: value),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: event.ended
            ? null
            : () async {
                if (widget.onSave != null) {
                  return widget.onSave?.call(event);
                }

                return Navigator.of(context).pop(event);
              },
        label: Text(L10n.of(context).saveSettings),
        icon: const Icon(Icons.save_rounded),
      ),
    );
  }
}
