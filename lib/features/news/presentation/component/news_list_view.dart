import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';
import 'package:news_test/features/news/presentation/component/news_list_item.dart';
import 'package:news_test/shared/router/app_router.dart';
import 'package:news_test/shared/style/app_theme.dart';

final class NewsListView extends StatelessWidget {
  final List<NewsArticleItemEntity> news;
  final bool showFavoriteButton;

  const NewsListView({
    super.key,
    required this.news,
    this.showFavoriteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navBarHeight = Theme.of(context).extension<AppThemeExtensions>()?.navBarHeight ?? 84;
    final bottomInset = math.max(
      mediaQuery.viewPadding.bottom,
      mediaQuery.systemGestureInsets.bottom,
    );

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 19).copyWith(
        top: 22,
        bottom: 40 + navBarHeight + math.max(bottomInset, 16),
      ),
      sliver: SliverList.separated(
        itemCount: news.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final article = news[index];

          return NewsListItem(
            article: article,
            itemIndex: index,
            onPressed: () => _pushArticleDetails(context, article.id),
            showFavoriteButton: showFavoriteButton,
          );
        },
      ),
    );
  }

  void _pushArticleDetails(final BuildContext context, final String articleId) =>
      GoRouter.of(context).pushArticleDetails(articleId);
}
