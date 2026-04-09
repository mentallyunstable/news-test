part of 'favorites_bloc.dart';

sealed class FavoritesBlocEvent {
  const FavoritesBlocEvent();

  const factory FavoritesBlocEvent.get() = GetFavoritesEvent;

  const factory FavoritesBlocEvent.add({
    required final NewsArticleItemEntity article,
  }) = AddFavoriteArticleEvent;

  const factory FavoritesBlocEvent.remove({
    required final String articleId,
  }) = RemoveFavoriteArticleEvent;
}

final class GetFavoritesEvent extends FavoritesBlocEvent {
  const GetFavoritesEvent();
}

final class AddFavoriteArticleEvent extends FavoritesBlocEvent {
  final NewsArticleItemEntity article;

  const AddFavoriteArticleEvent({
    required this.article,
  });
}

final class RemoveFavoriteArticleEvent extends FavoritesBlocEvent {
  final String articleId;

  const RemoveFavoriteArticleEvent({
    required this.articleId,
  });
}
