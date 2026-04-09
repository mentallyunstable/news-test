part of 'favorites_bloc.dart';

sealed class FavoritesBlocState {
  const FavoritesBlocState({required this.data});

  final BaseFavoritesBlocStateData data;

  const factory FavoritesBlocState.initial({
    required final BaseFavoritesBlocStateData data,
  }) = InitialFavoritesBlocState;

  const factory FavoritesBlocState.loading({
    required final BaseFavoritesBlocStateData data,
  }) = LoadingFavoritesBlocState;

  const factory FavoritesBlocState.error({
    required final BaseFavoritesBlocStateData data,
    required final String message,
  }) = ErrorFavoritesBlocState;
}

final class InitialFavoritesBlocState extends FavoritesBlocState {
  const InitialFavoritesBlocState({required super.data});
}

final class LoadingFavoritesBlocState extends FavoritesBlocState {
  const LoadingFavoritesBlocState({required super.data});
}

final class ErrorFavoritesBlocState extends FavoritesBlocState {
  const ErrorFavoritesBlocState({
    required super.data,
    required this.message,
  });

  final String message;
}
