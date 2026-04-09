import 'package:flutter/material.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';
import 'package:news_test/features/news/presentation/component/article_image.dart';
import 'package:news_test/features/news/presentation/component/favorite_icon_button.dart';

final class NewsListItem extends StatelessWidget {
  final NewsArticleItemEntity article;
  final VoidCallback onPressed;
  final bool showFavoriteButton;

  const NewsListItem({
    super.key,
    required this.article,
    required this.onPressed,
    this.showFavoriteButton = false,
  });

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
                  child: ArticleImage(
                    imageUrl: article.urlToImage,
                    imageBuilder: (_, imageProvider) => Ink.image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const .symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                article.titleText,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyLarge,
                              ),
                            ),
                            if (showFavoriteButton) ...[
                              const SizedBox(width: 8),
                              FavoriteIconButton(
                                article: article,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints.tightFor(
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            article.descriptionText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium,
                          ),
                        ),
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
