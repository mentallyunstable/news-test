import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/news/bloc/news_bloc.dart';
import 'package:news_test/features/news/presentation/component/article_image.dart';
import 'package:news_test/features/news/presentation/component/favorite_icon_button.dart';

final class ArticleDetailsScreen extends StatelessWidget {
  final String? articleId;

  const ArticleDetailsScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          FavoriteIconButton(
            isFavorite: false,
            onPressed: () {
              // TODO: implement favorite state change
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsBlocState>(
        builder: (context, state) {
          final id = articleId;

          if (id == null) {
            return const Center(
              child: Text('Article not found'),
            );
          }

          final article = state.data.findArticleById(id);

          if (article == null) {
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
                Text(
                  article.titleText,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  article.descriptionText,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      article.source.nameLabel,
                      style: textTheme.titleSmall,
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
                Text(
                  article.contentText,
                  style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
