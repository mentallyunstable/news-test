import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/shared/utils/logger.dart';

/// Logs bloc state changes and errors.
final class AppBlocObserver extends BlocObserver {
  const AppBlocObserver({required this.logger});

  final AppLogger logger;

  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<Object?, Object?> transition,
  ) {
    logger.info(
      'Bloc ${bloc.runtimeType}: ${transition.currentState.runtimeType} '
      '-> ${transition.nextState.runtimeType}',
    );
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    logger.error(
      'Bloc ${bloc.runtimeType} error',
      exception: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
