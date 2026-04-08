import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';
import 'package:news_test/features/news/domain/repository/news_repository.dart';
import 'package:news_test/shared/utils/bloc_try_catcher_mixin.dart';

part 'news_bloc_event.dart';
part 'news_bloc_state.dart';
part 'news_bloc_state_data.dart';

final class NewsBloc extends Bloc<NewsBlocEvent, NewsBlocState> with BlocTryCatcherMixin {
  final NewsRepository _repository;

  Future<NewsBlocState> get doneLoading async => await stream.firstWhere(
    (state) => state is! LoadingNewsBlocState,
  );

  NewsBloc({
    required final NewsRepository repository,
  }) : _repository = repository,
       super(NewsBlocState.initial(data: NewsBlocStateData.initial())) {
    on<NewsBlocEvent>(
      (event, emit) => switch (event) {
        final GetNewsBlocEvent e => _onGetNewsBlocEvent(e, emit),
      },
    );
  }

  FutureOr<void> _onGetNewsBlocEvent(
    final GetNewsBlocEvent event,
    final Emitter<NewsBlocState> emit,
  ) async {
    await tryCatch(event, emit, () async {
      emit(.loading(data: state.data));

      final response = await _repository.getNews();

      emit(
        .initial(data: state.data.copyWith(news: response.articles)),
      );
    });
  }

  @override
  void emitError(final Emitter<NewsBlocState> emit, final String message) {
    emit(.error(data: state.data, message: message));
  }
}
