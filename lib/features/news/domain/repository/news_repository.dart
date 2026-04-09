import 'package:dio/dio.dart';
import 'package:news_test/features/news/domain/entity/news_response_entity.dart';

abstract interface class NewsRepository {
  const NewsRepository();

  Future<NewsResponseEntity> getNews({
    required String category,
    String? query,
    CancelToken? cancelToken,
  });
}
