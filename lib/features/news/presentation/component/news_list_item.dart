import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';

final class NewsListItem extends StatelessWidget {
  final NewsArticleItemEntity article;
  final VoidCallback onPressed;

  const NewsListItem({super.key, required this.article, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return SizedBox(
      height: 112,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(16)),
          boxShadow: [
            BoxShadow(
              blurRadius: 6.1,
              spreadRadius: 0,
              offset: const Offset(0, 3),
              color: Colors.black.withValues(alpha: 0.15),
            ),
          ],
        ),
        child: Material(
          color: colorScheme.surface,
          borderRadius: const .all(.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            borderRadius: const .all(.circular(16)),
            child: Row(
              children: [
                SizedBox(
                  width: 112,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage,
                    imageBuilder: (context, imageProvider) => Ink.image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const .symmetric(vertical: 5, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          article.titleLabel,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          article.descriptionLabel,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Align(
                          alignment: .centerEnd,
                          child: Text(
                            article.formattedDate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
