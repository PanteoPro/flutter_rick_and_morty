import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_app/logic/domain/entity/character.dart';

part 'location.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Location extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final String dimension;
  @HiveField(4)
  final List<String> residents;
  @HiveField(5)
  final String url;
  @HiveField(6)
  final DateTime created;

  @HiveField(7)
  @JsonKey(fromJson: _toNull)
  HiveList<Character>? charactersRelation;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  static dynamic _toNull(dynamic _) => null;
}
