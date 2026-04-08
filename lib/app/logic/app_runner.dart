import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:news_test/app/constant/app_config.dart';
import 'package:news_test/app/initialization/logic/initialization_processor.dart';
import 'package:news_test/app/initialization/widget/initialization_failed_app.dart';
import 'package:news_test/app/widget/app_widget.dart';
import 'package:news_test/shared/utils/app_bloc_observer.dart';
import 'package:news_test/shared/utils/logger.dart';

/// Responsible for initialization and running the app.
final class AppRunner {
  final AppConfig config;

  const AppRunner({required this.config});

  /// Starts the initialization and, on success, runs the application.
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    final systemLocale = binding.platformDispatcher.locale.toLanguageTag();

    await initializeDateFormatting(systemLocale);
    Intl.defaultLocale = systemLocale;

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    binding.deferFirstFrame();

    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError = logger.logPlatformDispatcherError;

    Bloc.observer = AppBlocObserver(logger: logger);

    final processor = InitializationProcessor(config: config);
    await _initializeAndRun(binding, processor);
  }

  Future<void> _initializeAndRun(
    final WidgetsBinding binding,
    final IInitializationProcessor initializationProcessor,
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
