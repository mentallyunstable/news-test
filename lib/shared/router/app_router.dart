import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:news_test/app/widget/app_shell.dart';
import 'package:news_test/features/favorites/presentation/favorites_screen.dart';
import 'package:news_test/features/news/presentation/article_details_screen.dart';
import 'package:news_test/features/news/presentation/news_screen.dart';

part 'app_router_extensions.dart';
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
                builder: (context, state) => const NewsScreen(),
              ),
              _articleRoute,
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouterPaths.favorites.name,
                path: AppRouterPaths.favorites.path,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  GoRoute get _articleRoute => GoRoute(
    name: AppRouterPaths.articleDetails.name,
    path: AppRouterPaths.articleDetails.path,
    builder: (context, state) {
      final articleId = state.pathParameters['article_id'];

      return ArticleDetailsScreen(articleId: articleId);
    },
  );
}
