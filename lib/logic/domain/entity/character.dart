import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/episode.dart';

part 'character.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Character extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String status;
  @HiveField(3)
  final String species;
  @HiveField(4)
  final String? type;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final Map<String, String> origin;
  @HiveField(7)
  final Map<String, String> location;
  @HiveField(8)
  final String image;
  @HiveField(9)
  final List<String> episode;
  @HiveField(10)
  final String url;
  @HiveField(11)
  @JsonKey(fromJson: _parseDateFromString)
  final DateTime? created;

  @HiveField(12)
  @JsonKey(fromJson: _toNull)
  HiveList<Episode>? episodesRelation;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  static dynamic _toNull(dynamic _) => null;

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }
}
