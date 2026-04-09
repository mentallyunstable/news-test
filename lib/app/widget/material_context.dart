import 'package:flutter/material.dart';
import 'package:news_test/app/dependencies/extensions/context_extension.dart';
import 'package:news_test/shared/style/app_theme.dart';

/// Configures the root [MaterialApp].
class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: context.dependencies.router.router,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
