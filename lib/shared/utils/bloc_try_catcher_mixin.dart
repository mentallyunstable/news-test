import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/app/constant/error_messages.dart';
import 'package:news_test/shared/data/common_error_model.dart';
import 'package:news_test/shared/utils/logger.dart';

/// Utility mixin for [Bloc] classes to handle exceptions and emit error states
mixin BlocTryCatcherMixin<E, S> on Bloc<E, S> {
  FutureOr<void> tryCatch(final E event, final Emitter<S> emit, final AsyncCallback callback) async {
    try {
      await callback();
    } on DioException catch (exception, stackTrace) {
      return catchDioException(
        event: event,
        emit: emit,
        exception: exception,
        stackTrace: stackTrace,
      );
    } catch (exception, stackTrace) {
      logger.error('$runtimeType Exception', exception: exception, stackTrace: stackTrace);

      return emitError(emit, ErrorMessages.unknownError);
    }
  }

  void catchDioException({
    required final E event,
    required final Emitter<S> emit,
    required final DioException exception,
    required final StackTrace stackTrace,
  }) {
    try {
      logger.error('$runtimeType DioException by $event', exception: exception, stackTrace: stackTrace);

      if (exception.type == DioExceptionType.cancel) {
        return;
      }

      final data = exception.response?.data;

      if (data == null) {
        return emitError(emit, ErrorMessages.unknownError);
      }

      final error = CommonErrorModel.fromJson(data);

      return emitError(emit, error.message);
    } catch (exception, stackTrace) {
      logger.error('$runtimeType Exception', exception: exception, stackTrace: stackTrace);

      return emitError(emit, ErrorMessages.unknownError);
    }
  }

  void emitError(final Emitter<S> emit, final String message);
}
