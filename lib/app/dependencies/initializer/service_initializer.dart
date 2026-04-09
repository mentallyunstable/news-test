import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_test/app/constant/app_config.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
import 'package:news_test/features/favorites/data/local/favorite_articles_db_migration.dart';
import 'package:news_test/shared/data/local/db_service.dart';
import 'package:news_test/shared/utils/api_key_interceptor.dart';

/// Defines [ServiceDependencies] initialization.
abstract interface class ServiceInitializer {
  Future<ServiceDependencies> initialize(AppConfig config);
}

/// Main implementation of [ServiceInitializer].
final class ServiceInitializerImpl implements ServiceInitializer {
  @override
  Future<ServiceDependencies> initialize(final AppConfig config) async {
    const timeoutDuration = Duration(seconds: 15);
    _validateEnvironment(config);

    Dio dio() {
      final dio = Dio(
        BaseOptions(
          baseUrl: config.environmentStore.apiBase,
          connectTimeout: timeoutDuration,
          receiveTimeout: timeoutDuration,
          sendTimeout: timeoutDuration,
        ),
      );

      dio.interceptors.addAll([
        ApiKeyInterceptor(apiKey: config.environmentStore.apiKey),
        if (kDebugMode)
          LogInterceptor(
            requestBody: true,
            responseBody: true,
          ),
      ]);

      return dio;
    }

    return ServiceDependenciesImpl(
      dio: dio,
      dbService: () => SqfliteDbService(
        migrations: const [
          FavoriteArticlesDbMigration(),
        ],
      ),
    );
  }

  void _validateEnvironment(final AppConfig config) {
    final apiBase = config.environmentStore.apiBase.trim();
    final apiKey = config.environmentStore.apiKey.trim();

    if (apiBase.isEmpty) {
      throw StateError(
        'Missing BASE_URL dart define. Build or run the app with --dart-define-from-file=config.json.',
      );
    }

    if (apiKey.isEmpty) {
      throw StateError(
        'Missing API_KEY dart define. Build or run the app with --dart-define-from-file=config.json.',
      );
    }
  }
}
