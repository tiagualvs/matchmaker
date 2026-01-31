import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/text_span_builder.dart';

abstract class Dialogs {
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required String content,
    required List<Widget> actions,
    bool barrierDismissible = true,
  }) async {
    return await showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: .bold),
          ),
          content: Text.rich(
            TextSpanBuilder.build(
              content,
              normalStyle: context.textTheme.bodyMedium,
              boldStyle: context.textTheme.bodyMedium?.copyWith(fontWeight: .bold),
            ),
          ),
          actions: actions,
        );
      },
    );
  }

  static Future<T?> display<T>(
    BuildContext context, {
    required Widget title,
    required Widget content,
    required List<Widget> actions,
    bool barrierDismissible = true,
    BoxConstraints? constraints,
  }) async {
    return await showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return Theme(
          data: context.theme.copyWith(
            dialogTheme: context.theme.dialogTheme.copyWith(
              titleTextStyle: context.textTheme.titleLarge?.copyWith(fontWeight: .bold),
              contentTextStyle: context.textTheme.bodyMedium,
            ),
          ),
          child: AlertDialog(
            backgroundColor: context.colorScheme.onPrimary,
            title: title,
            content: content,
            actions: actions,
            constraints: constraints,
          ),
        );
      },
    );
  }
}
