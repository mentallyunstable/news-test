import 'dart:async';

import 'package:news_test/app/constant/app_config.dart';
import 'package:news_test/app/initialization/model/environment_store.dart';
import 'package:news_test/app/logic/app_runner.dart';
import 'package:news_test/shared/utils/logger.dart';

/// Default local entry point.
void main() {
  const environment = EnvironmentStore();
  const config = AppConfig(
    environmentStore: environment,
    appTitle: 'News',
  );

  runZonedGuarded(
    () => const AppRunner(config: config).initializeAndRun(),
    logger.logZoneError,
  );
}
