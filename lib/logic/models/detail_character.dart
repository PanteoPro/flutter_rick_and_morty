import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/character.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/episode.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/navigation/main_navigation.dart';

class DetailCharacterModel extends ChangeNotifier {
  final Character? character;
  DetailCharacterModel({required this.character});

  void onEpisodeTap(Episode episode, BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.episodeDetail, arguments: episode);
  }
}
