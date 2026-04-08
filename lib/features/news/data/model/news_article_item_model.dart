import 'package:json_annotation/json_annotation.dart';
import 'package:news_test/features/news/data/model/news_source_model.dart';

part 'news_article_item_model.g.dart';

@JsonSerializable()
final class NewsArticleItemModel {
  final NewsSourceModel source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String? content;

  const NewsArticleItemModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.publishedAt,
  });

  factory NewsArticleItemModel.fromJson(Map<String, dynamic> json) => _$NewsArticleItemModelFromJson(json);
}
