import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({super.key, required this.label, required this.child, this.spacing = 4.0});

  final String label;
  final Widget child;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing,
      crossAxisAlignment: .stretch,
      children: [
        Text(label, style: context.textTheme.bodyMedium),
        child,
      ],
    );
  }
}
