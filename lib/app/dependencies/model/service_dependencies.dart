import 'package:dio/dio.dart';
import 'package:news_test/app/dependencies/model/lazy_factory.dart';

/// Defines all services and third-party dependencies.
abstract base class ServiceDependencies {
  const ServiceDependencies();

  Dio dio();
}

/// Main implementation of [ServiceDependencies].
final class ServiceDependenciesImpl extends ServiceDependencies {
  ServiceDependenciesImpl({
    required LazyFactory<Dio> dio,
  }) : _dio = LazyDependency(dio);

  final LazyDependency<Dio> _dio;

  @override
  Dio dio() => _dio.get();
}
