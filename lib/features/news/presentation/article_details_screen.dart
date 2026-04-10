import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/favorites/bloc/favorites_bloc.dart';
import 'package:news_test/features/news/bloc/news_bloc.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';
import 'package:news_test/features/news/presentation/component/article_image.dart';
import 'package:news_test/features/news/presentation/component/favorite_icon_button.dart';
import 'package:news_test/shared/constant/semantics_identifiers.dart';

final class ArticleDetailsScreen extends StatelessWidget {
  final String? articleId;

  const ArticleDetailsScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return BlocBuilder<NewsBloc, NewsBlocState>(
      builder: (context, newsState) {
        return BlocBuilder<FavoritesBloc, FavoritesBlocState>(
          builder: (context, favoritesState) {
            final id = articleId;
            final article = id == null
                ? null
                : newsState.data.findArticleById(id) ?? favoritesState.data.findArticleById(id);

            return Scaffold(
              appBar: AppBar(
                actions: [
                  if (article != null)
                    FavoriteIconButton(
                      article: article,
                      semanticsIdentifier: SemanticsIdentifiers.articleDetailsFavoriteButton,
                    ),
                ],
              ),
              body: _ArticleDetailsBody(
                articleId: articleId,
                article: article,
                textTheme: textTheme,
              ),
            );
          },
        );
      },
    );
  }
}

final class _ArticleDetailsBody extends StatelessWidget {
  const _ArticleDetailsBody({
    required this.articleId,
    required this.article,
    required this.textTheme,
  });

  final String? articleId;
  final NewsArticleItemEntity? article;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final article = this.article;

    if (articleId == null || article == null) {
      return const Center(
        child: Text('Article not found'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16).copyWith(
        bottom: 40 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Semantics(
            container: true,
            identifier: SemanticsIdentifiers.articleDetailsTitleText,
            child: Text(
              article.titleText,
              style: textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            article.descriptionText,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Semantics(
                container: true,
                identifier: SemanticsIdentifiers.articleDetailsSourceText,
                child: Text(
                  article.source.nameLabel,
                  style: textTheme.titleSmall,
                ),
              ),
              const Spacer(),
              Text(
                article.formattedDate,
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: const .all(.circular(16)),
            child: SizedBox(
              height: 265,
              width: .infinity,
              child: ArticleImage(imageUrl: article.urlToImage),
            ),
          ),
          const SizedBox(height: 18),
          Semantics(
            container: true,
            identifier: SemanticsIdentifiers.articleDetailsContentText,
            child: Text(
              article.contentText,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
