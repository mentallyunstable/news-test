import 'package:json_annotation/json_annotation.dart';

part 'news_source_model.g.dart';

@JsonSerializable()
final class NewsSourceModel {
  final String? id;
  final String? name;

  const NewsSourceModel({this.id, this.name});

  factory NewsSourceModel.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceModelFromJson(json);
}
