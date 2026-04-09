import 'package:dio/dio.dart';
import 'package:news_test/app/dependencies/model/lazy_factory.dart';
import 'package:news_test/shared/data/local/db_service.dart';

/// Defines all services and third-party dependencies.
abstract base class ServiceDependencies {
  const ServiceDependencies();

  Dio dio();

  DbService dbService();
}

/// Main implementation of [ServiceDependencies].
final class ServiceDependenciesImpl extends ServiceDependencies {
  ServiceDependenciesImpl({
    required LazyFactory<Dio> dio,
    required LazyFactory<DbService> dbService,
  }) : _dio = LazyDependency(dio),
       _dbService = LazyDependency(dbService);

  final LazyDependency<Dio> _dio;
  final LazyDependency<DbService> _dbService;

  @override
  Dio dio() => _dio.get();

  @override
  DbService dbService() => _dbService.get();
}
