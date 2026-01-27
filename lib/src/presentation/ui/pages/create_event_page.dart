import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/presentation/controllers/create_event_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/label_widget.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.controller});

  final CreateEventController controller;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  CreateEventController get controller => widget.controller;

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
                onPressed: () => showModalBottomSheet(
                  context: context,
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
                          FilledButton(
                            onPressed: () {
                              controller.handleEventChanges(
                                controller.event.copyWith(teams: []),
                              );

                              return context.pop();
                            },
                            child: const Text('Reiniciar Times'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
                    Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: context.theme.dividerColor,
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          spacing: 4.0,
                          crossAxisAlignment: .stretch,
                          children: [
                            Text(
                              team.name,
                              textAlign: .center,
                              style: context.textTheme.titleMedium,
                            ),
                            const Divider(),
                            for (final player in team.players) ...[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  spacing: 8.0,
                                  children: [
                                    SizedBox.square(
                                      dimension: 32.0,
                                      child: Material(
                                        shape: const CircleBorder(),
                                        color: switch (player.gender) {
                                          PlayerGenderMale _ => Colors.blue.withAlpha((255 * 0.1).toInt()),
                                          PlayerGenderFemale _ => Colors.pink.withAlpha((255 * 0.1).toInt()),
                                          _ => Colors.blueGrey.withAlpha((255 * 0.1).toInt()),
                                        },
                                        child: Padding(
                                          padding: const .all(4.0),
                                          child: switch (player.gender) {
                                            PlayerGenderMale _ => const Icon(
                                              Icons.male_rounded,
                                              color: Colors.blue,
                                              size: 22.0,
                                            ),
                                            PlayerGenderFemale _ => const Icon(
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
                                    ),
                                    Text(
                                      player.name,
                                      style: context.textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
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
                        onPressed: disabled ? null : controller.importFromRawList,
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
                        const ButtonSegment(value: PlayerGender.male(), label: Text('Masculino')),
                        const ButtonSegment(value: PlayerGender.female(), label: Text('Feminino')),
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
                                    PlayerGenderMale _ => Colors.blue.withAlpha((255 * 0.1).toInt()),
                                    PlayerGenderFemale _ => Colors.pink.withAlpha((255 * 0.1).toInt()),
                                    _ => Colors.blueGrey.withAlpha((255 * 0.1).toInt()),
                                  },
                                  child: Padding(
                                    padding: const .all(4.0),
                                    child: switch (player.gender) {
                                      PlayerGenderMale _ => const Icon(
                                        Icons.male_rounded,
                                        color: Colors.blue,
                                        size: 22.0,
                                      ),
                                      PlayerGenderFemale _ => const Icon(
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
          extendBody: true,
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: switch (controller.event.teams.isEmpty) {
              true => FilledButton.icon(
                onPressed: controller.players.isEmpty
                    ? null
                    : () => controller.handleGenerateTeams(
                        onSuccess: () {
                          return SnackBars.success('Times gerados com sucesso!');
                        },
                        onError: (error) {
                          return SnackBars.error(error);
                        },
                      ),
                icon: const Icon(Icons.groups_rounded),
                label: const Text('Gerar Times'),
              ),
              false => FilledButton.icon(
                onPressed: () => controller.handleSaveEvent(
                  onSuccess: () {
                    SnackBars.success('Evento salvo com sucesso!');

                    return context.pop();
                  },
                ),
                icon: const Icon(Icons.save_rounded),
                label: const Text('Salvar Evento'),
              ),
            },
          ),
        );
      },
    );
  }
}
