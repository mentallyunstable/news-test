import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_test/app/constant/app_config.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
import 'package:news_test/shared/utils/api_key_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Defines [ServiceDependencies] initialization.
abstract interface class ServiceInitializer {
  Future<ServiceDependencies> initialize(AppConfig config);
}

/// Main implementation of [ServiceInitializer].
final class ServiceInitializerImpl implements ServiceInitializer {
  @override
  Future<ServiceDependencies> initialize(final AppConfig config) async {
    const timeoutDuration = Duration(seconds: 15);

    Future<SharedPreferences> preferences() async => await SharedPreferences.getInstance();

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
      sharedPreferences: preferences,
      secureStorage: () => const FlutterSecureStorage(),
      dio: dio,
    );
  }
}
