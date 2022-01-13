import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/character.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/info_response.dart';

part 'all_character_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllCharacterResponse {
  final InfoResponse info;
  @JsonKey(name: 'results')
  final List<Character> characters;

  AllCharacterResponse({
    required this.info,
    required this.characters,
  });

  factory AllCharacterResponse.fromJson(Map<String, dynamic> json) => _$AllCharacterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllCharacterResponseToJson(this);
}
