import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:material_symbols_icons/symbols.dart';

class PlayerInputWidget extends StatefulWidget {
  const PlayerInputWidget({
    super.key,
    this.player,
    this.withGenderSelect = true,
    this.withLevelSelect = true,
    required this.onSave,
  });

  final PlayerEntity? player;
  final bool withGenderSelect;
  final bool withLevelSelect;
  final ValueChanged<PlayerEntity> onSave;

  @override
  State<PlayerInputWidget> createState() => _PlayerInputWidgetState();
}

class _PlayerInputWidgetState extends State<PlayerInputWidget> {
  PlayerEntity? get player => widget.player;
  final formKey = GlobalKey<FormState>();
  late final controller = TextEditingController(text: player?.name);
  late final gender = <PlayerGender>{?player?.gender};
  late final level = <PlayerLevel>{?player?.level};

  void setGender(Set<PlayerGender> value) {
    setState(() {
      gender.clear();
      gender.addAll(value);
    });
  }

  void setLevel(Set<PlayerLevel> value) {
    setState(() {
      level.clear();
      level.addAll(value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            Text(
              player == null
                  ? L10n.of(context).registerPlayer
                  : L10n.of(context).editPlayer,
              style: context.textTheme.titleMedium,
            ),
            TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return L10n.of(context).playerNameRequired;
                }

                return null;
              },
              decoration: InputDecoration(
                labelText: L10n.of(context).playerNameLabel,
                hintText: L10n.of(context).playerNameHint,
                floatingLabelBehavior: .always,
              ),
            ),
            if (widget.withGenderSelect) ...[
              FormField<PlayerGender>(
                initialValue: gender.firstOrNull,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    return L10n.of(context).playerGenderRequired;
                  }

                  return null;
                },
                errorBuilder: (context, errorText) => Padding(
                  padding: const .symmetric(horizontal: 16.0),
                  child: Text(
                    errorText,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                ),
                builder: (field) {
                  return Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .stretch,
                    children: [
                      SegmentedButton<PlayerGender>(
                        emptySelectionAllowed: true,
                        segments: [
                          ButtonSegment(
                            value: PlayerGender.male,
                            label: Text(L10n.of(context).male),
                          ),
                          ButtonSegment(
                            value: PlayerGender.female,
                            label: Text(L10n.of(context).female),
                          ),
                        ],
                        multiSelectionEnabled: false,
                        showSelectedIcon: false,
                        style: SegmentedButton.styleFrom(
                          foregroundColor: switch (field.hasError) {
                            true => context.colorScheme.error,
                            _ => null,
                          },
                          side: switch (field.hasError) {
                            true => BorderSide(
                              color: context.colorScheme.error,
                              width: 0.5,
                            ),
                            _ => null,
                          },
                        ),
                        onSelectionChanged: (value) {
                          field.didChange(value.firstOrNull);
                          return setGender(value);
                        },
                        selected: gender,
                      ),
                      if (field.hasError) ...[
                        field.widget.errorBuilder?.call(
                              context,
                              field.errorText ?? L10n.of(context).validateGenderError,
                            ) ??
                            const SizedBox(),
                      ],
                    ],
                  );
                },
              ),
            ],
            if (widget.withLevelSelect) ...[
              FormField<PlayerLevel>(
                initialValue: level.firstOrNull,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    return L10n.of(context).playerLevelRequired;
                  }

                  return null;
                },
                errorBuilder: (context, errorText) => Padding(
                  padding: const .symmetric(horizontal: 16.0),
                  child: Text(
                    errorText,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                ),
                builder: (field) {
                  return Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .stretch,
                    children: [
                      SegmentedButton<PlayerLevel>(
                        emptySelectionAllowed: true,
                        segments: List.from(
                          PlayerLevel.values.map(
                            (level) => ButtonSegment(
                              value: level,
                              label: Text(level.emoji),
                            ),
                          ),
                        ),
                        multiSelectionEnabled: false,
                        showSelectedIcon: false,
                        style: SegmentedButton.styleFrom(
                          foregroundColor: switch (field.hasError) {
                            true => context.colorScheme.error,
                            _ => null,
                          },
                          side: switch (field.hasError) {
                            true => BorderSide(
                              color: context.colorScheme.error,
                              width: 0.5,
                            ),
                            _ => null,
                          },
                        ),
                        onSelectionChanged: (value) {
                          field.didChange(value.firstOrNull);
                          return setLevel(value);
                        },
                        selected: level,
                      ),
                      if (field.hasError) ...[
                        field.widget.errorBuilder?.call(
                              context,
                              field.errorText ?? L10n.of(context).validateLevelError,
                            ) ??
                            const SizedBox(),
                      ],
                    ],
                  );
                },
              ),
            ],
            FilledButton.icon(
              key: const ValueKey('PlayerInputWidget.saveButton'),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  return widget.onSave(
                    player?.copyWith(
                          name: controller.text,
                          gender: widget.withGenderSelect ? gender.first : PlayerGender.unknown,
                          level: widget.withLevelSelect ? level.first : PlayerLevel.basic,
                        ) ??
                        PlayerEntity(
                          id: -1,
                          name: controller.text,
                          gender: widget.withGenderSelect ? gender.first : PlayerGender.unknown,
                          level: widget.withLevelSelect ? level.first : PlayerLevel.basic,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                  );
                }
              },
              icon: const Icon(Symbols.save_rounded),
              label: Text(L10n.of(context).saveLabel),
            ),
          ],
        ),
      ),
    );
  }
}
