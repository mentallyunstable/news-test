import 'package:news_test/app/dependencies/model/lazy_factory.dart';
import 'package:news_test/features/favorites/data/local/favorite_articles_local_data_source.dart';

/// Defines app local data source dependencies.
abstract base class LocalDataSourceDependencies {
  const LocalDataSourceDependencies();

  FavoriteArticlesLocalDataSource favoriteArticlesLocalDataSource();
}

/// Main implementation of [LocalDataSourceDependencies].
final class LocalDataSourceDependenciesImpl extends LocalDataSourceDependencies {
  LocalDataSourceDependenciesImpl({
    required LazyFactory<FavoriteArticlesLocalDataSource> favoriteArticlesLocalDataSource,
  }) : _favoriteArticlesLocalDataSource = LazyDependency(favoriteArticlesLocalDataSource);

  final LazyDependency<FavoriteArticlesLocalDataSource> _favoriteArticlesLocalDataSource;

  @override
  FavoriteArticlesLocalDataSource favoriteArticlesLocalDataSource() => _favoriteArticlesLocalDataSource.get();
}
