import 'package:intl/intl.dart';
import 'package:news_test/features/news/data/model/news_article_item_model.dart';
import 'package:news_test/features/news/domain/entity/news_source_entity.dart';

final class NewsArticleItemEntity {
  final NewsSourceEntity source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String? content;

  const NewsArticleItemEntity({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticleItemEntity.fromModel(final NewsArticleItemModel model) {
    return NewsArticleItemEntity(
      source: NewsSourceEntity.fromModel(model.source),
      author: model.author,
      title: model.title,
      description: model.description,
      url: model.url,
      urlToImage: model.urlToImage,
      publishedAt: model.publishedAt,
      content: model.content,
    );
  }

  String get titleLabel => title.trim();

  String get descriptionLabel => description.trim();

  String get formattedDate => DateFormat.yMd(
    Intl.getCurrentLocale(),
  ).format(publishedAt.toLocal());

  String get contentText => content ?? 'Article content is empty';
}
