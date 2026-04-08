import 'package:news_test/features/news/data/model/news_response_model.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';

final class NewsResponseEntity {
  const NewsResponseEntity({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<NewsArticleItemEntity> articles;

  factory NewsResponseEntity.fromModel(NewsResponseModel model) {
    return NewsResponseEntity(
      status: model.status,
      totalResults: model.totalResults,
      articles: model.articles
          .map(NewsArticleItemEntity.fromModel)
          .toList(),
    );
  }
}
