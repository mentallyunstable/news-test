part of 'news_bloc.dart';

sealed class NewsBlocEvent {
  const NewsBlocEvent();

  const factory NewsBlocEvent.get() = GetNewsBlocEvent;
}

final class GetNewsBlocEvent extends NewsBlocEvent {
  const GetNewsBlocEvent();
}
