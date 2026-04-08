part of 'app_router.dart';

extension AppRouterExtensions on GoRouter {
  void pushArticleDetails(int articleIndex) => pushNamed(
    AppRouterPaths.articleDetails.name,
    pathParameters: {'article_index': articleIndex.toString()},
  );
}
