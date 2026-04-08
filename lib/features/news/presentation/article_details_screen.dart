import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/news/bloc/news_bloc.dart';

final class ArticleDetailsScreen extends StatelessWidget {
  final int? articleIndex;

  const ArticleDetailsScreen({super.key, required this.articleIndex});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<NewsBloc, NewsBlocState>(
        builder: (context, state) {
          final index = articleIndex;

          if (index == null) {
            return const Center(
              child: Text('Article not found'),
            );
          }

          // TODO: implement id for articles
          final article = state.data.news[index];

          return SingleChildScrollView(
            padding: const .all(16),
            child: Column(
              children: [
                Text(
                  article.title,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  article.description,
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
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage,
                    fit: .cover,
                    height: 265,
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
