import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:news_test/app/widget/app_shell.dart';
import 'package:news_test/features/main/view/main_screen.dart';

part 'app_router_paths.dart';

/// Defines app navigation service using go_router.
final class AppRouter {
  AppRouter({
    required this.rootNavigatorKey,
    required this.shellNavigatorKey,
  });

  final GlobalKey<NavigatorState> rootNavigatorKey;
  final GlobalKey<NavigatorState> shellNavigatorKey;

  late final GoRouter router = GoRouter(
    initialLocation: AppRouterPaths.main.path,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) => AppShell(shell: child),
        parentNavigatorKey: rootNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: shellNavigatorKey,
            routes: [
              GoRoute(
                name: AppRouterPaths.main.name,
                path: AppRouterPaths.main.path,
                builder: (context, state) => const MainScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
