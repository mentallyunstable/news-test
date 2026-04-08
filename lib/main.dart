import 'dart:async';

import 'package:news_test/app/logic/app_runner.dart';
import 'package:news_test/core/utils/logger.dart';

/// Default local entry point.
void main() {
  runZonedGuarded(
    () => const AppRunner().initializeAndRun(),
    logger.logZoneError,
  );
}
