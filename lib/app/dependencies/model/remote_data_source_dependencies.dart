import 'package:news_test/app/dependencies/model/lazy_factory.dart';
import 'package:news_test/features/news/domain/data_source/news_remote_data_source.dart';

/// Defines app remote data source dependencies.
abstract base class RemoteDataSourceDependencies {
  const RemoteDataSourceDependencies();

  NewsRemoteDataSource newsRemoteDataSource();
}

/// Main implementation of [RemoteDataSourceDependencies].
final class RemoteDataSourceDependenciesImpl extends RemoteDataSourceDependencies {
  RemoteDataSourceDependenciesImpl({
    required LazyFactory<NewsRemoteDataSource> newsRemoteDataSource,
  }) : _newsRemoteDataSource = LazyDependency(newsRemoteDataSource);

  final LazyDependency<NewsRemoteDataSource> _newsRemoteDataSource;

  @override
  NewsRemoteDataSource newsRemoteDataSource() => _newsRemoteDataSource.get();
}
