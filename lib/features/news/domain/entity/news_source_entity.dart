import 'package:news_test/features/news/data/model/news_source_model.dart';

final class NewsSourceEntity {
  const NewsSourceEntity({this.id, this.name});

  final String? id;
  final String? name;

  factory NewsSourceEntity.fromModel(NewsSourceModel model) {
    return NewsSourceEntity(id: model.id, name: model.name);
  }

  String get nameLabel => name ?? 'No source';
}
