import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Defines [ServiceDependencies] initialization.
abstract interface class ServiceInitializer {
  Future<ServiceDependencies> initialize();
}

/// Main implementation of [ServiceInitializer].
final class ServiceInitializerImpl implements ServiceInitializer {
  @override
  Future<ServiceDependencies> initialize() async {
    const timeoutDuration = Duration(seconds: 15);

    Future<SharedPreferences> preferences() async => await SharedPreferences.getInstance();

    Dio dio() => Dio(
      BaseOptions(
        connectTimeout: timeoutDuration,
        receiveTimeout: timeoutDuration,
        sendTimeout: timeoutDuration,
      ),
    );

    return ServiceDependenciesImpl(
      sharedPreferences: preferences,
      secureStorage: () => const FlutterSecureStorage(),
      dio: dio,
    );
  }
}
