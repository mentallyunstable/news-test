import 'package:news_test/app/dependencies/model/local_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
import 'package:news_test/features/favorites/data/local/favorite_articles_local_data_source.dart';

/// Defines [LocalDataSourceDependencies] initialization.
abstract interface class LocalDataSourceInitializer {
  Future<LocalDataSourceDependencies> initialize({
    required ServiceDependencies services,
  });
}

/// Main implementation of [LocalDataSourceInitializer].
final class LocalDataSourceInitializerImpl implements LocalDataSourceInitializer {
  @override
  Future<LocalDataSourceDependencies> initialize({
    required final ServiceDependencies services,
  }) async {
    return LocalDataSourceDependenciesImpl(
      favoriteArticlesLocalDataSource: () => FavoriteArticlesLocalDataSourceImpl(
        dbService: services.dbService(),
      ),
    );
  }
}
