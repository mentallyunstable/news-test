import 'package:dio/dio.dart';
import 'package:news_test/app/constant/api_url.dart';
import 'package:news_test/features/news/data/model/news_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'news_remote_data_source.g.dart';

@RestApi()
abstract class NewsRemoteDataSource {
  factory NewsRemoteDataSource(Dio dio, {String? baseUrl}) = _NewsRemoteDataSource;

  @GET(ApiUrl.topHeadlines)
  Future<NewsResponseModel> getNews({
    @Query('country') String country = 'us',
  });
}
