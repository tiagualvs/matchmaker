import 'package:flutter/material.dart';

abstract class TextSpanBuilder {
  static TextSpan build(String text, {TextStyle? normalStyle, TextStyle? boldStyle}) {
    final spans = <TextSpan>[];

    final regex = RegExp(r'\[b\].+?\[\/b\]');
    int currentIndex = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: normalStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: text.substring(match.start + 3, match.end - 4),
          style:
              boldStyle ??
              normalStyle?.copyWith(fontWeight: FontWeight.bold) ??
              const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: normalStyle,
        ),
      );
    }

    return TextSpan(children: spans);
  }
}
