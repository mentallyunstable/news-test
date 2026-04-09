part of 'app_router.dart';

extension AppRouterExtensions on GoRouter {
  void pushArticleDetails(String articleId) => pushNamed(
    AppRouterPaths.articleDetails.name,
    pathParameters: {'article_id': articleId},
  );
}
