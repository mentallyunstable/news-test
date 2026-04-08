import 'package:news_test/app/dependencies/model/local_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/remote_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/repository_dependencies.dart';

/// Defines [RepositoryDependencies] initialization.
abstract interface class RepositoryInitializer {
  RepositoryDependencies initialize({
    required LocalDataSourceDependencies permanentDataSources,
    required RemoteDataSourceDependencies remoteDataSources,
  });
}

/// Main implementation of [RepositoryInitializer].
final class RepositoryInitializerImpl implements RepositoryInitializer {
  @override
  RepositoryDependencies initialize({
    required final LocalDataSourceDependencies permanentDataSources,
    required final RemoteDataSourceDependencies remoteDataSources,
  }) {
    return const RepositoryDependenciesImpl();
  }
}
