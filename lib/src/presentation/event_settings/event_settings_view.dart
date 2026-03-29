import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/extensions/num_ext.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';

import 'event_settings_view_model.dart';

class EventSettingsView extends EventSettingsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: context.pop,
        ),
        title: Text(L10n.of(context).settings),
      ),
      body: switch (loading) {
        true => const Center(child: CircularProgressIndicator()),
        false => SingleChildScrollView(
          padding: .all(2.unit),
          child: Column(
            spacing: 2.unit,
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
                keyboardType: .text,
                onChanged: setName,
                enabled: !event.ended,
                decoration: InputDecoration(
                  hintText: L10n.of(context).nameLabel,
                  labelText: L10n.of(context).eventNameLabel,
                  floatingLabelBehavior: .always,
                ),
              ),
              TextFormField(
                initialValue: event.maxScore.toString(),
                keyboardType: .number,
                onChanged: (value) {
                  if (value.isEmpty) return;

                  return setMaxScore(int.parse(value));
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
                keyboardType: .number,
                enabled: event.teams.isEmpty && !event.ended,
                onChanged: (value) {
                  if (value.isEmpty) return;

                  return setMaxPlayerPerTeam(int.parse(value));
                },
                decoration: InputDecoration(
                  hintText: L10n.of(context).quantityLabel,
                  labelText: L10n.of(context).playersPerTeamLabel,
                  floatingLabelBehavior: .always,
                ),
              ),
              TextFormField(
                initialValue: event.maxWinsInARow.toString(),
                keyboardType: .number,
                onChanged: (value) {
                  if (value.isEmpty) return;

                  return setMaxWinsInARow(int.parse(value));
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
                onChanged: event.ended ? null : setHalfScoreToEliminate,
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
                    ? setBalancedByGender
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
                    ? setBalancedByLevel
                    : null,
              ),
            ],
          ),
        ),
      },
    );
  }
}
