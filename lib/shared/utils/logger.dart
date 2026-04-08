import 'package:flutter/foundation.dart';

AppLogger get logger => const AppLogger();

/// Small logger used across the starter project.
final class AppLogger {
  const AppLogger();

  void logZoneError(Object error, StackTrace stackTrace) {
    this.error('Zone error', exception: error, stackTrace: stackTrace);
  }

  void logFlutterError(FlutterErrorDetails details) {
    error(
      'Flutter error',
      exception: details.exception,
      stackTrace: details.stack,
    );
  }

  bool logPlatformDispatcherError(Object error, StackTrace stackTrace) {
    this.error(
      'Platform dispatcher error',
      exception: error,
      stackTrace: stackTrace,
    );
    return true;
  }

  void info(String message) => _print('INFO', message);

  void error(String message, {Object? exception, StackTrace? stackTrace}) {
    final buffer = StringBuffer(message);

    if (exception != null) {
      buffer.write('\n$exception');
    }

    if (stackTrace != null) {
      buffer.write('\n$stackTrace');
    }

    _print('ERROR', buffer.toString());
  }

  void _print(String level, String message) {
    debugPrint('[${DateTime.now().toIso8601String()}] [$level] $message');
  }
}
