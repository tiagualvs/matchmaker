import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/presentation/controllers/create_event_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/label_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.controller});

  final CreateEventController controller;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  CreateEventController get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    });
  }

  @override
  void dispose() {
    controller.resetController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (controller.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                controller.resetController();
                return context.pop();
              },
            ),
            title: Text(controller.event.name),
            actions: [
              IconButton(
                onPressed: () async {
                  final result = await showModalBottomSheet<String>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0).copyWith(bottom: 48.0),
                        child: Column(
                          spacing: 16.0,
                          crossAxisAlignment: .stretch,
                          mainAxisSize: .min,
                          children: [
                            Text(
                              'Configurações do Evento',
                              textAlign: .center,
                              style: context.textTheme.titleMedium,
                            ),
                            LabelWidget(
                              label: 'Nome do evento',
                              child: TextFormField(
                                initialValue: controller.event.name,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  return controller.handleEventChanges(
                                    controller.event.copyWith(name: value),
                                  );
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Nome',
                                ),
                              ),
                            ),
                            LabelWidget(
                              label: 'Quantidade de pontos para vencer',
                              child: TextFormField(
                                initialValue: controller.event.maxScore.toString(),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (value.isEmpty) return;

                                  return controller.handleEventChanges(
                                    controller.event.copyWith(maxScore: int.parse(value)),
                                  );
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Quantidade',
                                ),
                              ),
                            ),
                            LabelWidget(
                              label: 'Quantidade de jogadores por time',
                              child: TextFormField(
                                initialValue: controller.event.maxPlayerPerTeam.toString(),
                                keyboardType: TextInputType.number,
                                enabled: controller.event.teams.isEmpty,
                                onChanged: (value) {
                                  if (value.isEmpty) return;

                                  return controller.handleEventChanges(
                                    controller.event.copyWith(maxPlayerPerTeam: int.parse(value)),
                                  );
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Quantidade',
                                ),
                              ),
                            ),
                            if (controller.event.teams.isEmpty) ...[
                              FilledButton.icon(
                                onPressed: () async {
                                  return context.pop('generate');
                                },
                                icon: const Icon(Icons.groups_rounded),
                                label: const Text('Gerar Times'),
                              ),
                            ],
                            if (controller.event.teams.isNotEmpty) ...[
                              FilledButton.icon(
                                onPressed: () {
                                  return context.pop('reset');
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: context.colorScheme.error,
                                ),
                                icon: const Icon(Icons.refresh_rounded),
                                label: const Text('Reiniciar Times'),
                              ),
                              FilledButton.icon(
                                onPressed: () async {
                                  return context.pop('save');
                                },
                                icon: const Icon(Icons.save_rounded),
                                label: const Text('Salvar Evento'),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  );

                  return switch (result) {
                    'generate' => controller.handleGenerateTeams(
                      onError: (error) {
                        return SnackBars.error(error);
                      },
                    ),
                    'reset' => controller.handleEventChanges(
                      controller.event.copyWith(teams: []),
                    ),
                    'save' => await controller.handleSaveEvent(
                      onSuccess: () {
                        context.pop(true);

                        return SnackBars.success('Evento salvo com sucesso!');
                      },
                      onError: (error) {
                        return SnackBars.error(error);
                      },
                    ),
                    _ => null,
                  };
                },
                icon: const Icon(Icons.settings_rounded),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0).copyWith(bottom: 128.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              spacing: 16.0,
              crossAxisAlignment: .stretch,
              children: [
                if (controller.event.teams.isNotEmpty) ...[
                  for (final team in controller.event.teams) ...[
                    TeamCardWidget(team: team, initiallyExpanded: true),
                  ],
                ],
                if (controller.event.teams.isEmpty) ...[
                  Text(
                    'Importar Jogadores',
                    style: context.textTheme.titleMedium,
                  ),
                  LabelWidget(
                    label: 'Lista de Jogadores',
                    child: TextField(
                      minLines: 5,
                      maxLines: 7,
                      controller: controller.importerController,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: '1 - Fulano de Tal - H\n2 - Sicrano de Tal\n3 - Elma Maria - M',
                      ),
                    ),
                  ),
                  ListenableBuilder(
                    listenable: controller.importerController,
                    builder: (context, child) {
                      final disabled = controller.importerController.text.isEmpty;
                      return FilledButton.icon(
                        onPressed: disabled
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                controller.importFromRawList();
                              },
                        icon: const Icon(Icons.upload_file_rounded),
                        label: const Text('Importar'),
                      );
                    },
                  ),
                  Row(
                    spacing: 16.0,
                    crossAxisAlignment: .center,
                    children: [
                      const Expanded(child: Divider()),
                      Text(
                        'ou',
                        style: context.textTheme.bodyMedium,
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  Text(
                    'Adicione Manualmente',
                    style: context.textTheme.titleMedium,
                  ),
                  LabelWidget(
                    label: 'Nome do Jogador',
                    child: TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        hintText: 'Fulano de Tal',
                      ),
                    ),
                  ),
                  LabelWidget(
                    label: 'Gênero',
                    spacing: 0,
                    child: SegmentedButton<PlayerGender>(
                      emptySelectionAllowed: true,
                      segments: [
                        const ButtonSegment(value: PlayerGender.male, label: Text('Masculino')),
                        const ButtonSegment(value: PlayerGender.female, label: Text('Feminino')),
                      ],
                      onSelectionChanged: controller.handleGenderChange,
                      selected: controller.selectedGender,
                    ),
                  ),
                  ListenableBuilder(
                    listenable: controller.nameController,
                    builder: (context, child) {
                      final disabled = controller.nameController.text.isEmpty || controller.selectedGender.isEmpty;

                      return FilledButton.icon(
                        onPressed: disabled ? null : controller.handleAddPlayer,
                        icon: const Icon(Icons.person_add_rounded),
                        label: const Text('Adicionar'),
                      );
                    },
                  ),
                  if (controller.players.isNotEmpty) ...[
                    Row(
                      spacing: 16.0,
                      crossAxisAlignment: .center,
                      children: [
                        const Expanded(child: Divider()),
                        Text(
                          'Lista de Jogadores (${controller.players.length})',
                          style: context.textTheme.bodyMedium,
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    ListView.separated(
                      separatorBuilder: (_, _) => const SizedBox(height: 8.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.players.length,
                      itemBuilder: (context, index) {
                        final player = controller.players[index];

                        return Material(
                          color: context.colorScheme.onPrimary,

                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            side: BorderSide(
                              width: 0.5,
                              color: context.colorScheme.primaryFixed,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0).copyWith(
                              right: 0.0,
                            ),
                            child: Row(
                              spacing: 16.0,
                              children: [
                                Material(
                                  shape: const CircleBorder(),
                                  color: switch (player.gender) {
                                    PlayerGender.male => Colors.blue.withAlpha((255 * 0.1).toInt()),
                                    PlayerGender.female => Colors.pink.withAlpha((255 * 0.1).toInt()),
                                    _ => Colors.blueGrey.withAlpha((255 * 0.1).toInt()),
                                  },
                                  child: Padding(
                                    padding: const .all(4.0),
                                    child: switch (player.gender) {
                                      PlayerGender.male => const Icon(
                                        Icons.male_rounded,
                                        color: Colors.blue,
                                        size: 22.0,
                                      ),
                                      PlayerGender.female => const Icon(
                                        Icons.female_rounded,
                                        color: Colors.pink,
                                        size: 22.0,
                                      ),
                                      _ => const Icon(
                                        Icons.person_rounded,
                                        color: Colors.blueGrey,
                                        size: 22.0,
                                      ),
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    player.name,
                                    style: context.textTheme.titleMedium,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => controller.handleRemovePlayer(index),
                                  icon: const Icon(Icons.delete_rounded),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
