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
            style: context.textTheme.headlineMedium?.copyWith(fontWeight: .bold),
          ),
          content: Text.rich(
            TextSpanBuilder.build(
              content,
              normalStyle: context.textTheme.bodyLarge,
              boldStyle: context.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
