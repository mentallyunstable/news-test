import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/favorites/data/local/favorite_articles_local_data_source.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';
import 'package:news_test/shared/utils/bloc_try_catcher_mixin.dart';

part 'favorites_bloc_event.dart';
part 'favorites_bloc_state.dart';
part 'favorites_bloc_state_data.dart';

final class FavoritesBloc extends Bloc<FavoritesBlocEvent, FavoritesBlocState> with BlocTryCatcherMixin {
  final FavoriteArticlesLocalDataSource _favoriteArticlesLocalDataSource;

  FavoritesBloc({
    required final FavoriteArticlesLocalDataSource favoriteArticlesLocalDataSource,
  }) : _favoriteArticlesLocalDataSource = favoriteArticlesLocalDataSource,
       super(FavoritesBlocState.initial(data: FavoritesBlocStateData.initial())) {
    on<FavoritesBlocEvent>(
      (event, emit) => switch (event) {
        final GetFavoritesEvent e => _onGetFavoritesEvent(e, emit),
        final AddFavoriteArticleEvent e => _onAddFavoriteArticleEvent(e, emit),
        final RemoveFavoriteArticleEvent e => _onRemoveFavoriteArticleEvent(e, emit),
      },
    );
  }

  FutureOr<void> _onGetFavoritesEvent(
    final GetFavoritesEvent event,
    final Emitter<FavoritesBlocState> emit,
  ) async {
    await tryCatch(event, emit, () async {
      final data = state.data;

      if (data.favoriteIds.isEmpty) {
        emit(.loading(data: data));
      }

      final favorites = await _favoriteArticlesLocalDataSource.getArticles();

      emit(
        .initial(
          data: data.copyWith(
            articlesById: _mergeArticles(data.articlesById, favorites),
            favoriteIds: favorites.map((article) => article.id).toList(),
          ),
        ),
      );
    });
  }

  FutureOr<void> _onAddFavoriteArticleEvent(
    final AddFavoriteArticleEvent event,
    final Emitter<FavoritesBlocState> emit,
  ) async {
    await tryCatch(event, emit, () async {
      await _favoriteArticlesLocalDataSource.saveArticle(event.article);

      final data = state.data;
      final favoriteIds = [
        event.article.id,
        ...data.favoriteIds.where((favoriteId) => favoriteId != event.article.id),
      ];

      emit(
        .initial(
          data: data.copyWith(
            articlesById: _mergeArticles(data.articlesById, [event.article]),
            favoriteIds: favoriteIds,
          ),
        ),
      );
    });
  }

  FutureOr<void> _onRemoveFavoriteArticleEvent(
    final RemoveFavoriteArticleEvent event,
    final Emitter<FavoritesBlocState> emit,
  ) async {
    await tryCatch(event, emit, () async {
      await _favoriteArticlesLocalDataSource.removeArticle(event.articleId);

      emit(
        .initial(
          data: state.data.copyWith(
            favoriteIds: state.data.favoriteIds.where((favoriteId) => favoriteId != event.articleId).toList(),
          ),
        ),
      );
    });
  }

  Map<String, NewsArticleItemEntity> _mergeArticles(
    final Map<String, NewsArticleItemEntity> current,
    final List<NewsArticleItemEntity> incoming,
  ) {
    return {
      ...current,
      for (final article in incoming) article.id: article,
    };
  }

  @override
  void emitError(final Emitter<FavoritesBlocState> emit, final String message) {
    emit(.error(data: state.data, message: message));
  }
}
