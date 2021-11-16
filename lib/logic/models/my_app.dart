import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/logic/domain/api/api_client.dart';
import 'package:rick_and_morty_app/logic/domain/data_providers/session_data_provider.dart';
import 'package:rick_and_morty_app/logic/domain/entity/character.dart';
import 'package:rick_and_morty_app/logic/domain/entity/episode.dart';
import 'package:rick_and_morty_app/logic/domain/entity/location.dart';

enum _EntityName { character, episode, location }

class MyAppModel extends ChangeNotifier {
  static const characterBoxName = 'characters';
  static const episodeBoxName = 'episodes';
  static const locationBoxName = 'locations';

  final _apiClient = ApiClient();
  var _isLoadProgress = false;
  var _loadProgressMessage = '';
  bool get isLoadProgress => _isLoadProgress;
  String get loadProgressMessage => _loadProgressMessage;

  late Box _characterBox;
  late Box _episodeBox;
  late Box _locationBox;

  var _isNeedSetupRelations = false;
  var _reloadAllByEpisode = false;
  var _isErrorInLoading = false;
  var _isStartLoadData = false;
  bool get isErrorInLoading => _isErrorInLoading;
  bool get isEmptyBoxes =>
      _isStartLoadData ? false : _characterBox.length == 0 || _episodeBox.length == 0 || _locationBox.length == 0;

  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> clearAll() async {
    await Hive.deleteFromDisk();
  }

  Future<void> initHive() async {
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(CharacterAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(EpisodeAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(LocationAdapter());

    if (!Hive.isBoxOpen(characterBoxName)) _characterBox = await Hive.openBox<Character>(characterBoxName);
    if (!Hive.isBoxOpen(episodeBoxName)) _episodeBox = await Hive.openBox<Episode>(episodeBoxName);
    if (!Hive.isBoxOpen(locationBoxName)) _locationBox = await Hive.openBox<Location>(locationBoxName);
  }

  // Future<void> debug() async {
  //   (_characterBox.values.toList() as List<Character>).forEach((element) {
  //     print(element.episodesRelation);
  //   });
  // }

  Future<void> loadData() async {
    _isStartLoadData = true;
    _reloadAllByEpisode = false;
    _isErrorInLoading = false;
    notifyListeners();
    try {
      await _loadEpisodes();
      await _loadCharacters();
      await _loadLocations();
    } catch (_) {
      _isErrorInLoading = true;
    }
    _reloadAllByEpisode = false;
    await _setupRelations();
    // debug();
    _isStartLoadData = false;
    notifyListeners();
  }

  void toLoadMark(bool flag, [String message = '']) {
    _isLoadProgress = flag;
    _loadProgressMessage = message;
  }

  Future<bool> _checkNewData(_EntityName entityName) async {
    switch (entityName) {
      case _EntityName.character:
        final infoResponse = (await _apiClient.getCharacters(1)).info;
        if (_characterBox.length != infoResponse.count) {
          return true;
        }
        return false;
      case _EntityName.episode:
        final infoResponse = (await _apiClient.getEpisodes(1)).info;
        if (_episodeBox.length != infoResponse.count) {
          return true;
        }
        return false;
      case _EntityName.location:
        final infoResponse = (await _apiClient.getLocations(1)).info;
        if (_locationBox.length != infoResponse.count) {
          return true;
        }
        return false;
    }
  }

  Future<void> _loadCharacters() async {
    bool isCharacterAlready(Character character) {
      return (_characterBox.values.toList() as List<Character>).any((characterBox) => characterBox.id == character.id);
    }

    if (!_isLoadProgress) {
      if (await _checkNewData(_EntityName.character) || _reloadAllByEpisode) {
        // print('load characters started');
        _isNeedSetupRelations = true;
        var page = 1;
        var pages = 1;
        toLoadMark(true, 'Загружаем персонажей');
        notifyListeners();
        while (page <= pages) {
          final characterResponse = await _apiClient.getCharacters(page);
          pages = characterResponse.info.pages;
          page += 1;
          characterResponse.characters.forEach((character) {
            if (!isCharacterAlready(character)) {
              _characterBox.add(character);
              // print('Character - ${character.name} was added');
            }
          });
        }
        toLoadMark(false);
      } else {
        // print('CharacterBox last version');
      }
    } else {
      // print('load characters in progress');
    }
    // print("load Characters End");
  }

  Future<void> _loadEpisodes() async {
    bool isEpisodeAlready(Episode episode) {
      return (_episodeBox.values.toList() as List<Episode>).any((episodeBox) => episodeBox.id == episode.id);
    }

    if (!_isLoadProgress) {
      if (await _checkNewData(_EntityName.episode)) {
        _reloadAllByEpisode = true;
        // print('load episodes started');
        _isNeedSetupRelations = true;
        var page = 1;
        var pages = 1;
        toLoadMark(true, 'Загружаем Эпизоды');
        notifyListeners();
        while (page <= pages) {
          final episodeResponse = await _apiClient.getEpisodes(page);
          pages = episodeResponse.info.pages;
          page += 1;
          episodeResponse.episodes.forEach((episode) {
            if (!isEpisodeAlready(episode)) {
              _episodeBox.add(episode);
              // print('Episode - ${episode.episode} was added');
            }
          });
        }
        toLoadMark(false);
      } else {
        // print('EpisoderBox last version');
      }
    } else {
      // print('load episodes in progress');
    }
    // print("load episodes End");
  }

  Future<void> _loadLocations() async {
    bool isLocationAlready(Location location) {
      return (_locationBox.values.toList() as List<Location>).any((locationBox) => locationBox.id == location.id);
    }

    if (!_isLoadProgress) {
      if (await _checkNewData(_EntityName.location) || _reloadAllByEpisode) {
        // print('load locations started');
        _isNeedSetupRelations = true;
        var page = 1;
        var pages = 1;
        toLoadMark(true, 'Загружаем Локации');
        notifyListeners();
        while (page <= pages) {
          final locationResponse = await _apiClient.getLocations(page);
          pages = locationResponse.info.pages;
          page += 1;
          locationResponse.locations.forEach((location) {
            if (!isLocationAlready(location)) {
              _locationBox.add(location);
              // print('Location - ${location.name} was added');
            }
          });
        }
        toLoadMark(false);
      } else {
        // print('LocationsBox last version');
      }
    } else {
      // print('load Locations in progress');
    }
    // print("load Locations End");
  }

  Future<void> _setupRelations() async {
    if (_isNeedSetupRelations) {
      _characterBox.values.toList() as List<Character>
        ..forEach((character) {
          final episodesUrl = character.episode;
          final relationEpisodes =
              (_episodeBox.values.toList() as List<Episode>).where((episode) => episodesUrl.indexOf(episode.url) >= 0);
          character.episodesRelation = HiveList(_episodeBox)..addAll(relationEpisodes);
          character.save();
        });
      _episodeBox.values.toList() as List<Episode>
        ..forEach((Episode episode) {
          final charactersUrl = episode.characters;
          final relationCharacters = (_characterBox.values.toList() as List<Character>)
              .where((character) => charactersUrl.indexOf(character.url) >= 0);
          episode.charactersRelation = HiveList(_characterBox)..addAll(relationCharacters);
          episode.save();
        });
      _locationBox.values.toList() as List<Location>
        ..forEach((Location location) {
          final charactersUrl = location.residents;
          final relationCharacters = (_characterBox.values.toList() as List<Character>)
              .where((character) => charactersUrl.indexOf(character.url) >= 0);
          location.charactersRelation = HiveList(_characterBox)..addAll(relationCharacters);
          location.save();
        });
      // print("setup relations End");
    } else {
      // print('setup relations dont need');
    }
  }
}
