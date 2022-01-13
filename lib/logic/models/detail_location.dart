import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/character.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/location.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/navigation/main_navigation.dart';

class DetailLocationModel extends ChangeNotifier {
  final Location? location;
  List<Character> _characters = <Character>[];
  List<Character> get characters => _characters;

  DetailLocationModel({required this.location});

  Future<void> init() async {
    if (location!.charactersRelation != null) {
      _characters.addAll(location!.charactersRelation!.toList());
    }
    notifyListeners();
  }

  void onCharacterTap(Character character, BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.characterDetail, arguments: character);
  }
}
