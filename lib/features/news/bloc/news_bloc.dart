import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';
import 'package:news_test/features/news/domain/repository/news_repository.dart';
import 'package:news_test/shared/utils/bloc_try_catcher_mixin.dart';

part 'news_bloc_event.dart';
part 'news_bloc_state.dart';
part 'news_bloc_state_data.dart';

final class NewsBloc extends Bloc<NewsBlocEvent, NewsBlocState> with BlocTryCatcherMixin {
  static const _searchDelay = Duration(milliseconds: 300);
  static const _minimumSearchQueryLength = 3;

  final NewsRepository _repository;

  NewsBloc({
    required final NewsRepository repository,
  }) : _repository = repository,
       super(NewsBlocState.initial(data: NewsBlocStateData.initial())) {
    on<NewsBlocEvent>(
      (event, emit) => switch (event) {
        final GetNewsBlocEvent e => _onGetNewsBlocEvent(e, emit),
        final SelectCategoryNewsEvent e => _onSelectCategoryNewsEvent(e, emit),
        _ => () {},
      },
      transformer: restartable(),
    );
    on<SearchNewsEvent>(
      _onSearchNewsEvent,
      transformer: restartable(),
    );
  }

  @override
  Future<void> close() {
    _cancelActiveRequest();

    return super.close();
  }

  // Token for cancelling repeatable requests
  CancelToken? _activeRequestCancelToken;

  Future<NewsBlocState> get doneLoading async => await stream.firstWhere(
    (state) => state is! LoadingNewsBlocState,
  );

  FutureOr<void> _onGetNewsBlocEvent(
    final GetNewsBlocEvent event,
    final Emitter<NewsBlocState> emit,
  ) async {
    await tryCatch(event, emit, () async {
      final data = state.data;

      emit(.loading(data: data));

      await Future.delayed(const Duration(milliseconds: 1000));

      final response = await _repository.getNews(category: data.selectedCategory);

      if (emit.isDone) {
        return;
      }

      final articles = response.articles;

      emit(
        .initial(
          data: data.copyWith(
            articlesById: _mergeArticles(data.articlesById, articles),
            newsIds: articles.map((article) => article.id).toList(),
          ),
        ),
      );
    });
  }

  FutureOr<void> _onSelectCategoryNewsEvent(
    final SelectCategoryNewsEvent event,
    final Emitter<NewsBlocState> emit,
  ) async {
    await tryCatch(event, emit, () async {
      if (event.category == state.data.selectedCategory) {
        return;
      }

      emit(
        .initial(
          data: state.data.copyWith(
            selectedCategory: event.category,
            articlesById: const {},
            newsIds: const [],
            searchResultIds: const [],
          ),
        ),
      );

      add(const .get());
    });
  }

  FutureOr<void> _onSearchNewsEvent(
    final SearchNewsEvent event,
    final Emitter<NewsBlocState> emit,
  ) async {
    final query = event.query.trim();
    final canSearch = query.length >= _minimumSearchQueryLength;

    if (query == state.data.searchQuery) {
      return;
    }

    _cancelActiveRequest();

    if (!canSearch) {
      if (state.data.searchQuery.isNotEmpty) {
        return emit(
          .initial(
            data: state.data.copyWith(
              articlesById: _retainArticlesByIds(
                state.data.articlesById,
                state.data.newsIds,
              ),
              searchQuery: query,
              searchResultIds: const [],
            ),
          ),
        );
      }

      return;
    }

    await Future.delayed(_searchDelay);

    if (emit.isDone) {
      return;
    }

    final retainedArticlesById = _retainArticlesByIds(
      state.data.articlesById,
      state.data.newsIds,
    );

    emit(
      .loading(
        data: state.data.copyWith(
          articlesById: retainedArticlesById,
          searchQuery: query,
          searchResultIds: const [],
        ),
      ),
    );

    final data = state.data;
    final response = await _repository.getNews(
      category: data.selectedCategory,
      query: data.searchQuery,
      cancelToken: _activeRequestCancelToken = _createCancelToken(),
    );
    final articles = response.articles;

    _activeRequestCancelToken = null;

    emit(
      .initial(
        data: data.copyWith(
          articlesById: _mergeArticles(data.articlesById, articles),
          searchResultIds: articles.map((article) => article.id).toList(),
        ),
      ),
    );
  }

  CancelToken _createCancelToken() {
    _cancelActiveRequest();

    final cancelToken = CancelToken();
    _activeRequestCancelToken = cancelToken;

    return cancelToken;
  }

  void _cancelActiveRequest() {
    final cancelToken = _activeRequestCancelToken;

    if (cancelToken != null && !cancelToken.isCancelled) {
      cancelToken.cancel();
    }

    _activeRequestCancelToken = null;
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

  Map<String, NewsArticleItemEntity> _retainArticlesByIds(
    final Map<String, NewsArticleItemEntity> current,
    final List<String> ids,
  ) {
    final retained = <String, NewsArticleItemEntity>{};

    for (final id in ids) {
      final article = current[id];

      if (article == null) {
        continue;
      }

      retained[id] = article;
    }

    return retained;
  }

  @override
  void emitError(final Emitter<NewsBlocState> emit, final String message) {
    emit(.error(data: state.data, message: message));
  }
}
