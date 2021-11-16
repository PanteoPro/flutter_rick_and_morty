import 'package:json_annotation/json_annotation.dart';

part 'info_response.g.dart';

@JsonSerializable()
class InfoResponse {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  InfoResponse({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory InfoResponse.fromJson(Map<String, dynamic> json) => _$InfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InfoResponseToJson(this);
}
