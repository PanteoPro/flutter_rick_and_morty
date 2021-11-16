// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_character_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCharacterResponse _$AllCharacterResponseFromJson(
        Map<String, dynamic> json) =>
    AllCharacterResponse(
      info: InfoResponse.fromJson(json['info'] as Map<String, dynamic>),
      characters: (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCharacterResponseToJson(
        AllCharacterResponse instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'results': instance.characters.map((e) => e.toJson()).toList(),
    };
