import 'package:json_annotation/json_annotation.dart';

part 'common_error_model.g.dart';

@JsonSerializable()
final class CommonErrorModel {
  final String status;
  final String code;
  final String message;

  const CommonErrorModel({required this.status, required this.code, required this.message});

  factory CommonErrorModel.fromJson(final Map<String, dynamic> json) => _$CommonErrorModelFromJson(json);
}
