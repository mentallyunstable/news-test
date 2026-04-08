import 'package:news_test/app/initialization/model/environment.dart';

class EnvironmentStore implements IEnvironmentStore {
  const EnvironmentStore();

  static final _env = Environment.from(const String.fromEnvironment('ENV'));

  @override
  Environment get environment => _env;

  @override
  String get apiBase => const String.fromEnvironment('BASE_URL');

  @override
  String get apiKey => const String.fromEnvironment('API_KEY');

  @override
  bool get isProd => _env == Environment.prod;

  @override
  bool get isDev => _env == Environment.dev;
}

abstract class IEnvironmentStore {
  abstract final Environment environment;

  String get apiBase;

  String get apiKey;

  bool get isProd;

  bool get isDev;
}
