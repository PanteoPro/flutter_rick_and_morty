// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_episode_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllEpisodeResponse _$AllEpisodeResponseFromJson(Map<String, dynamic> json) =>
    AllEpisodeResponse(
      info: InfoResponse.fromJson(json['info'] as Map<String, dynamic>),
      episodes: (json['results'] as List<dynamic>)
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllEpisodeResponseToJson(AllEpisodeResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.episodes,
    };
