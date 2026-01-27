import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_router.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';

import 'app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Match Maker',
      routerConfig: AppRouter.router,
      builder: SnackBars.builder,
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
