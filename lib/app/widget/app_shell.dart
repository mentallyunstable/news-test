import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Minimal shell wrapper for branched navigation.
final class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.shell,
  });

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
    );
  }
}
