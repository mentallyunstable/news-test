part of 'news_bloc.dart';

abstract class BaseNewsBlocStateData {
  final Map<String, NewsArticleItemEntity> articlesById;
  final List<String> newsIds;
  final List<String> searchResultIds;
  final String selectedCategory;
  final String searchQuery;

  const BaseNewsBlocStateData({
    required this.articlesById,
    required this.newsIds,
    required this.searchResultIds,
    required this.selectedCategory,
    required this.searchQuery,
  });

  List<NewsArticleItemEntity> get news => newsIds.map((id) => articlesById[id]!).toList();

  List<NewsArticleItemEntity> get searchResults => searchResultIds.map((id) => articlesById[id]!).toList();

  NewsArticleItemEntity? findArticleById(final String id) => articlesById[id];

  BaseNewsBlocStateData copyWith({
    Map<String, NewsArticleItemEntity>? articlesById,
    List<String>? newsIds,
    List<String>? searchResultIds,
    String? selectedCategory,
    String? searchQuery,
  });
}

final class NewsBlocStateData extends BaseNewsBlocStateData {
  const NewsBlocStateData({
    required super.articlesById,
    required super.newsIds,
    required super.searchResultIds,
    required super.selectedCategory,
    required super.searchQuery,
  });

  factory NewsBlocStateData.initial() => const NewsBlocStateData(
    articlesById: {},
    newsIds: [],
    searchResultIds: [],
    selectedCategory: 'general',
    searchQuery: '',
  );

  @override
  BaseNewsBlocStateData copyWith({
    final Map<String, NewsArticleItemEntity>? articlesById,
    final List<String>? newsIds,
    final List<String>? searchResultIds,
    final String? selectedCategory,
    final String? searchQuery,
  }) {
    return NewsBlocStateData(
      articlesById: articlesById ?? this.articlesById,
      newsIds: newsIds ?? this.newsIds,
      searchResultIds: searchResultIds ?? this.searchResultIds,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
