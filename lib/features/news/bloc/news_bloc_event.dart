part of 'news_bloc.dart';

sealed class NewsBlocEvent {
  const NewsBlocEvent();

  const factory NewsBlocEvent.get() = GetNewsBlocEvent;

  const factory NewsBlocEvent.selectCategory({
    required final String category,
  }) = SelectCategoryNewsEvent;

  const factory NewsBlocEvent.searchQueryChanged({
    required final String query,
  }) = SearchNewsEvent;
}

final class GetNewsBlocEvent extends NewsBlocEvent {
  const GetNewsBlocEvent();
}

final class SelectCategoryNewsEvent extends NewsBlocEvent {
  final String category;

  const SelectCategoryNewsEvent({
    required this.category,
  });
}

final class SearchNewsEvent extends NewsBlocEvent {
  final String query;

  const SearchNewsEvent({
    required this.query,
  });
}
