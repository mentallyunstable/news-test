import 'package:news_test/app/initialization/model/environment_store.dart';

/// Application configuration
final class AppConfig {
  /// Creates a new [AppConfig] instance.
  const AppConfig({
    required this.environmentStore,
    required this.appTitle,
  });

  /// The current environment.
  final IEnvironmentStore environmentStore;

  final String appTitle;
}
