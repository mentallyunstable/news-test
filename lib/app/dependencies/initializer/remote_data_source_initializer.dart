import 'package:news_test/app/dependencies/model/remote_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';

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
    return const RemoteDataSourceDependenciesImpl();
  }
}
