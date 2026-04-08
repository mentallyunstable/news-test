import 'package:json_annotation/json_annotation.dart';
import 'package:news_test/features/news/data/model/news_article_item_model.dart';

part 'news_response_model.g.dart';

@JsonSerializable()
final class NewsResponseModel {
  final String status;
  final int totalResults;
  final List<NewsArticleItemModel> articles;

  const NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) => _$NewsResponseModelFromJson(json);
}
