import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/app/initialization/logic/initialization_processor.dart';
import 'package:news_test/app/initialization/widget/initialization_failed_app.dart';
import 'package:news_test/app/widget/app_widget.dart';
import 'package:news_test/core/utils/app_bloc_observer.dart';
import 'package:news_test/core/utils/logger.dart';

/// Responsible for initialization and running the app.
final class AppRunner {
  const AppRunner();

  /// Starts the initialization and, on success, runs the application.
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    binding.deferFirstFrame();

    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError =
        logger.logPlatformDispatcherError;

    Bloc.observer = AppBlocObserver(logger: logger);

    const processor = InitializationProcessor();
    await _initializeAndRun(binding, processor);
  }

  Future<void> _initializeAndRun(
    WidgetsBinding binding,
    IInitializationProcessor initializationProcessor,
  ) async {
    try {
      final result = await initializationProcessor.initialize();
      runApp(AppWidget(result: result));
    } catch (exception, stackTrace) {
      logger.error(
        'Initialization failed',
        exception: exception,
        stackTrace: stackTrace,
      );
      runApp(
        InitializationFailedApp(
          exception: exception,
          stackTrace: stackTrace,
          retryInitialization: initializeAndRun,
        ),
      );
    } finally {
      binding.allowFirstFrame();
    }
  }
}
