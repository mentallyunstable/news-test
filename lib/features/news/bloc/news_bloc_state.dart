part of 'news_bloc.dart';

sealed class NewsBlocState {
  final BaseNewsBlocStateData data;

  const NewsBlocState({required this.data});

  const factory NewsBlocState.initial({
    required final BaseNewsBlocStateData data,
  }) = InitialNewsBlocState;

  const factory NewsBlocState.loading({
    required final BaseNewsBlocStateData data,
  }) = LoadingNewsBlocState;

  const factory NewsBlocState.error({
    required final BaseNewsBlocStateData data,
    required final String message,
  }) = ErrorNewsBlocState;
}

final class InitialNewsBlocState extends NewsBlocState {
  const InitialNewsBlocState({required super.data});
}

final class LoadingNewsBlocState extends NewsBlocState {
  const LoadingNewsBlocState({required super.data});
}

final class ErrorNewsBlocState extends NewsBlocState {
  final String message;

  const ErrorNewsBlocState({required super.data, required this.message});
}
