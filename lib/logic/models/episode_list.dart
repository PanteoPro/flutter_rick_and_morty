import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/logic/domain/entity/episode.dart';
import 'package:rick_and_morty_app/logic/models/my_app.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';

class EpisodeListModel extends ChangeNotifier {
  final _episodes = <Episode>[];
  var _filteredEpisodes = <Episode>[];
  List<Episode> get filteredCharacters => List.unmodifiable(_filteredEpisodes);

  final searchTextController = TextEditingController();

  Future<void> init() async {
    _loadEpisodes();
    searchTextController.addListener(_search);
    _filteredEpisodes = _episodes;
  }

  void _search() {
    final query = searchTextController.text.toLowerCase();
    _filteredEpisodes = _episodes.where((element) => element.name.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  Future<void> _loadEpisodes() async {
    _episodes.clear();
    try {
      final episodeBox = Hive.box<Episode>(MyAppModel.episodeBoxName);
      _episodes.addAll(episodeBox.values.toList());
      notifyListeners();
    } catch (e) {}
  }

  void onEpisodeTap(Episode episode, BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.episodeDetail, arguments: episode);
  }

  void showEpisodeAtIndex(int index) {
    if (index == _episodes.length - 3) {
      // _loadEpisodes();
    }
  }
}
