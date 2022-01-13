import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/info_response.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/location.dart';

part 'all_location_response.g.dart';

@JsonSerializable()
class AllLocationResponse {
  final InfoResponse info;
  @JsonKey(name: 'results')
  final List<Location> locations;

  AllLocationResponse({required this.info, required this.locations});

  factory AllLocationResponse.fromJson(Map<String, dynamic> json) => _$AllLocationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllLocationResponseToJson(this);
}
