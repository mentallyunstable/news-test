import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';
import 'package:news_test/features/news/presentation/component/news_list_item.dart';
import 'package:news_test/shared/router/app_router.dart';
import 'package:news_test/shared/style/app_theme.dart';

final class NewsListView extends StatelessWidget {
  final List<NewsArticleItemEntity> news;

  const NewsListView({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    final navBarHeight =
        Theme.of(context).extension<AppThemeExtensions>()?.navBarHeight ?? 84;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 19).copyWith(
        top: 22,
        bottom: 40 + navBarHeight + MediaQuery.viewPaddingOf(context).bottom,
      ),
      sliver: SliverList.separated(
        itemCount: news.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) => NewsListItem(
          article: news[index],
          onPressed: () => _pushArticleDetails(context, index),
        ),
      ),
    );
  }

  void _pushArticleDetails(final BuildContext context, final int index) =>
      GoRouter.of(context).pushArticleDetails(index);
}
