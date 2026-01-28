import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';

class EventSettingsDialog extends StatefulWidget {
  const EventSettingsDialog({
    super.key,
    required this.event,
    this.hideAppBar = false,
    this.onSave,
  });

  final EventEntity event;
  final bool hideAppBar;
  final Future<void> Function(EventEntity event)? onSave;

  @override
  State<EventSettingsDialog> createState() => _EventSettingsDialogState();
}

class _EventSettingsDialogState extends State<EventSettingsDialog> {
  late EventEntity event = widget.event;

  void handleEventChanges(EventEntity event) {
    setState(() {
      this.event = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: switch (widget.hideAppBar) {
        true => null,
        false => AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => context.pop(),
          ),
          title: const Text('Configurações'),
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
              'Configurações do Evento${event.ended ? ' (Finalizado)' : ''}',
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
              decoration: const InputDecoration(
                hintText: 'Nome',
                labelText: 'Nome do Evento',
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
              decoration: const InputDecoration(
                hintText: 'Quantidade',
                labelText: 'Quantidade de pontos para vencer',
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
              decoration: const InputDecoration(
                hintText: 'Quantidade',
                labelText: 'Quantidade de jogadores por time',
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
              decoration: const InputDecoration(
                hintText: 'Quantidade',
                labelText: 'Máximo de vitórias em sequência',
                floatingLabelBehavior: .always,
              ),
            ),
            SwitchListTile(
              value: event.halfScoreToEliminate,
              contentPadding: .zero,
              materialTapTargetSize: .shrinkWrap,
              title: const Text('Eliminar na metade?'),
              subtitle: Text('Elimina o time que estiver perdendo por ${(event.maxScore / 2).round()} x 0.'),
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
              title: const Text('Balancear por gênero?'),
              subtitle: const Text('Mesma quantidade de homens e mulheres por time.'),
              onChanged: event.teams.isEmpty || !event.ended
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
              title: const Text('Balancear por nível?'),
              subtitle: const Text('Mesma quantidade de jogadores por nível por time.'),
              onChanged: null,
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

                return context.pop(event);
              },
        label: const Text('Salvar configurações'),
        icon: const Icon(Icons.save_rounded),
      ),
    );
  }
}
