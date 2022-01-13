import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/episode.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/info_response.dart';

part 'all_episode_response.g.dart';

@JsonSerializable()
class AllEpisodeResponse {
  final InfoResponse info;
  @JsonKey(name: 'results')
  final List<Episode> episodes;

  AllEpisodeResponse({required this.info, required this.episodes});

  factory AllEpisodeResponse.fromJson(Map<String, dynamic> json) => _$AllEpisodeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllEpisodeResponseToJson(this);
}
