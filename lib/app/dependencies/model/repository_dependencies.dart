import 'package:news_test/app/dependencies/model/lazy_factory.dart';
import 'package:news_test/features/news/domain/repository/news_repository.dart';

/// Defines app repository dependencies.
abstract base class RepositoryDependencies {
  const RepositoryDependencies();

  NewsRepository newsRepository();
}

/// Main implementation of [RepositoryDependencies].
final class RepositoryDependenciesImpl extends RepositoryDependencies {
  RepositoryDependenciesImpl({required final LazyFactory<NewsRepository> newsRepository})
    : _newsRepository = LazyDependency(newsRepository);

  final LazyDependency<NewsRepository> _newsRepository;

  @override
  NewsRepository newsRepository() => _newsRepository.get();
}
