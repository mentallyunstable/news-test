part of 'news_bloc.dart';

abstract class BaseNewsBlocStateData {
  final List<NewsArticleItemEntity> news;

  const BaseNewsBlocStateData({required this.news});

  BaseNewsBlocStateData copyWith({List<NewsArticleItemEntity>? news});
}

final class NewsBlocStateData extends BaseNewsBlocStateData {
  const NewsBlocStateData({required super.news});

  factory NewsBlocStateData.initial() => const NewsBlocStateData(news: []);

  @override
  BaseNewsBlocStateData copyWith({
    final List<NewsArticleItemEntity>? news,
  }) {
    return NewsBlocStateData(
      news: news ?? this.news,
    );
  }
}
