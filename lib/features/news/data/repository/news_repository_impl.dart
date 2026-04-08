import 'package:news_test/features/news/domain/data_source/news_remote_data_source.dart';
import 'package:news_test/features/news/domain/entity/news_response_entity.dart';
import 'package:news_test/features/news/domain/repository/news_repository.dart';

final class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _remoteDataSource;

  const NewsRepositoryImpl({
    required final NewsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<NewsResponseEntity> getNews() async {
    final response = await _remoteDataSource.getNews();

    return NewsResponseEntity.fromModel(response);
  }
}
