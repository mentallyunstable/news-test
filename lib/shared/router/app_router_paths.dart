part of 'app_router.dart';

/// Contains const route paths and names.
sealed class AppRouterPaths {
  const AppRouterPaths._();

  static const initial = AppRouteEntry(path: '/', name: 'initial');
  static const main = AppRouteEntry(path: '/main', name: 'main');
  static const favorites = AppRouteEntry(path: '/favorites', name: 'favorites');

  static const articleDetails = AppRouteEntry(
    path: '/article-details/:article_index',
    name: 'article-details',
  );
}

/// Describes an individual route entity.
final class AppRouteEntry {
  const AppRouteEntry({required this.path, required this.name});

  final String path;
  final String name;
}
