// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllLocationResponse _$AllLocationResponseFromJson(Map<String, dynamic> json) =>
    AllLocationResponse(
      info: InfoResponse.fromJson(json['info'] as Map<String, dynamic>),
      locations: (json['results'] as List<dynamic>)
          .map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllLocationResponseToJson(
        AllLocationResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.locations,
    };
