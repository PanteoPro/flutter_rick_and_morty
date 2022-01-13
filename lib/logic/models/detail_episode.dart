import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/character.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/episode.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/navigation/main_navigation.dart';

class DetailEpisodeModel extends ChangeNotifier {
  final Episode? episode;
  final _characters = <Character>[];
  List<Character> get characters => _characters;

  DetailEpisodeModel({required this.episode});

  Future<void> init() async {
    if (episode!.charactersRelation != null) {
      _characters.addAll(episode!.charactersRelation!.toList());
    }
    notifyListeners();
  }

  void onCharacterTap(Character character, BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.characterDetail, arguments: character);
  }
}
