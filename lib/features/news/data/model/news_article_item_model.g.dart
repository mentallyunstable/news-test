// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticleItemModel _$NewsArticleItemModelFromJson(
  Map<String, dynamic> json,
) => NewsArticleItemModel(
  source: NewsSourceModel.fromJson(json['source'] as Map<String, dynamic>),
  author: json['author'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  url: json['url'] as String,
  urlToImage: json['urlToImage'] as String?,
  content: json['content'] as String?,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
);
