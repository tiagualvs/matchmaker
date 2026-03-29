import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_router.dart';
import 'package:matchmaker/src/common/l10n/l10n.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';

import 'app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key}) : _locale = null;
  const AppWidget.test({super.key}) : _locale = const Locale('en');

  final Locale? _locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      routerConfig: AppRouter.config,
      builder: SnackBars.builder,
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
