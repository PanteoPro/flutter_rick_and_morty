import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/character.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/my_app.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/navigation/main_navigation.dart';

class CharacterListModel extends ChangeNotifier {
  final _characters = <Character>[];
  var _filteredCharacters = <Character>[];
  List<Character> get filteredCharacters => List.unmodifiable(_filteredCharacters);

  final searchTextController = TextEditingController();

  Future<void> init() async {
    _loadCharacters();
    searchTextController.addListener(_search);
    _filteredCharacters = _characters;
  }

  void _search() {
    final query = searchTextController.text.toLowerCase();
    _filteredCharacters = _characters.where((element) => element.name.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  Future<void> _loadCharacters() async {
    _characters.clear();
    try {
      final characterBox = Hive.box<Character>(MyAppModel.characterBoxName);
      _characters.addAll(characterBox.values.toList());
      notifyListeners();
    } catch (e) {}
  }

  void onCharacterTap(Character character, BuildContext context) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.characterDetail,
      arguments: character,
    );
  }

  void showCharacterAtIndex(int index) {
    if (index == _characters.length - 3) {
      // _loadCharacters();
    }
  }
}
