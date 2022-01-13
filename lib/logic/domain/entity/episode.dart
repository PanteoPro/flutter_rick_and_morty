import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/character.dart';

part 'episode.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Episode extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String air_date;
  @HiveField(3)
  final String episode;
  @HiveField(4)
  final List<String> characters;
  @HiveField(5)
  final String url;
  @HiveField(6)
  final DateTime created;

  @HiveField(7)
  @JsonKey(fromJson: _toNull)
  HiveList<Character>? charactersRelation;

  String get episodeSeries => episode.substring(1).split('E')[1];
  String get episodeNumber => episode.substring(1).split('E')[0];

  Episode({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  static dynamic _toNull(dynamic _) => null;
}
