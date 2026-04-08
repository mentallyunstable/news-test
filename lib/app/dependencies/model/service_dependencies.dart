import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_test/app/dependencies/model/lazy_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Defines all services and third-party dependencies.
abstract base class ServiceDependencies {
  const ServiceDependencies();

  Future<SharedPreferences> sharedPreferences();
  FlutterSecureStorage secureStorage();
  Dio dio();
}

/// Main implementation of [ServiceDependencies].
final class ServiceDependenciesImpl extends ServiceDependencies {
  ServiceDependenciesImpl({
    required LazyFactory<Future<SharedPreferences>> sharedPreferences,
    required LazyFactory<FlutterSecureStorage> secureStorage,
    required LazyFactory<Dio> dio,
  }) : _sharedPreferences = LazyDependency(sharedPreferences),
       _secureStorage = LazyDependency(secureStorage),
       _dio = LazyDependency(dio);

  final LazyDependency<Future<SharedPreferences>> _sharedPreferences;
  final LazyDependency<FlutterSecureStorage> _secureStorage;
  final LazyDependency<Dio> _dio;

  @override
  Future<SharedPreferences> sharedPreferences() => _sharedPreferences.get();

  @override
  FlutterSecureStorage secureStorage() => _secureStorage.get();

  @override
  Dio dio() => _dio.get();
}
