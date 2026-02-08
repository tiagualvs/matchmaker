import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension CommonFindersExt on CommonFinders {
  Finder appBarWithTextTitle(String text) {
    return find.byWidgetPredicate((w) {
      if (w is! AppBar) return false;

      final title = w.title;

      if (title is! Text) return false;

      return title.data == text;
    });
  }

  Finder listTileWithTextTitle(String text) {
    return find.byWidgetPredicate((w) {
      if (w is! ListTile) return false;

      final title = w.title;

      if (title is! Text) return false;

      return title.data == text;
    });
  }

  Finder fabWithIconData(IconData icon) {
    return find.byWidgetPredicate((w) {
      if (w is! FloatingActionButton) return false;

      final c = w.child;

      if (c is! Icon) return false;

      return c.icon == icon;
    });
  }

  Finder fabWithAnimatedIconData(AnimatedIconData icon) {
    return find.byWidgetPredicate((w) {
      if (w is! FloatingActionButton) return false;

      final c = w.child;

      if (c is! AnimatedIcon) return false;

      return c.icon == icon;
    });
  }

  Finder switchListTile(String title, bool value) {
    return find.byWidgetPredicate((w) {
      if (w is! SwitchListTile) return false;

      return w.title is Text && (w.title as Text).data == title && w.value == value;
    });
  }
}
