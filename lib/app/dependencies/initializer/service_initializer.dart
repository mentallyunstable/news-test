import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_test/app/constant/app_config.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
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
    );
  }
}
