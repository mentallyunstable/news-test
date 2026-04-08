import 'package:news_test/app/dependencies/model/remote_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
import 'package:news_test/features/news/domain/data_source/news_remote_data_source.dart';

/// Defines [RemoteDataSourceDependencies] initialization.
abstract interface class RemoteDataSourceInitializer {
  RemoteDataSourceDependencies initialize({required ServiceDependencies services});
}

/// Main implementation of [RemoteDataSourceInitializer].
final class RemoteDataSourceInitializerImpl implements RemoteDataSourceInitializer {
  @override
  RemoteDataSourceDependencies initialize({
    required final ServiceDependencies services,
  }) {
    return RemoteDataSourceDependenciesImpl(
      newsRemoteDataSource: () => NewsRemoteDataSource(services.dio()),
    );
  }
}
