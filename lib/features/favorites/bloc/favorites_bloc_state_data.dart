part of 'favorites_bloc.dart';

abstract class BaseFavoritesBlocStateData {
  BaseFavoritesBlocStateData({
    required this.articlesById,
    required this.favoriteIds,
  }) : favoriteIdsLookup = Set.unmodifiable(favoriteIds);

  final Map<String, NewsArticleItemEntity> articlesById;
  final List<String> favoriteIds;
  final Set<String> favoriteIdsLookup;

  List<NewsArticleItemEntity> get favorites => favoriteIds.map((id) => articlesById[id]!).toList();

  NewsArticleItemEntity? findArticleById(final String id) => articlesById[id];

  bool isFavorite(final String articleId) => favoriteIdsLookup.contains(articleId);

  BaseFavoritesBlocStateData copyWith({
    Map<String, NewsArticleItemEntity>? articlesById,
    List<String>? favoriteIds,
  });
}

final class FavoritesBlocStateData extends BaseFavoritesBlocStateData {
  FavoritesBlocStateData({
    required super.articlesById,
    required super.favoriteIds,
  });

  factory FavoritesBlocStateData.initial() => FavoritesBlocStateData(
    articlesById: {},
    favoriteIds: [],
  );

  @override
  BaseFavoritesBlocStateData copyWith({
    final Map<String, NewsArticleItemEntity>? articlesById,
    final List<String>? favoriteIds,
  }) {
    return FavoritesBlocStateData(
      articlesById: articlesById ?? this.articlesById,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}
