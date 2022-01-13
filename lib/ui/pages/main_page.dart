import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/Theme/app_colors.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/character_list.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/episode_list.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/location_list.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/my_app.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/constants.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/widgets/main/characters/character_list_widget.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/widgets/main/episodes/episodes_list_widget.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/widgets/main/locations/locations_list_widget.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/widgets/main/news/news_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final characterListModel = CharacterListModel();
  final episodeListModel = EpisodeListModel();
  final locationListModel = LocationListModel();

  var _selectedTab = 0;

  void _changeTab(int index) {
    if (_selectedTab != index) {
      _selectedTab = index;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initModels();
  }

  void initModels() {
    characterListModel.init();
    episodeListModel.init();
    locationListModel.init();
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = NotifierProvider.read<MyAppModel>(context);
    mainModel?.addListener(initModels);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.mainAppBarText),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const NewsWidget(),
          NotifierProvider<CharacterListModel>(
            model: characterListModel,
            child: const CharacterListWidget(),
          ),
          NotifierProvider<EpisodeListModel>(
            model: episodeListModel,
            child: const EpisodeListWidget(),
          ),
          NotifierProvider(
            model: locationListModel,
            child: const LocationListWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: _changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppTexts.mainBottomMenuNewsText,
            backgroundColor: AppColors.mainDark,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppTexts.mainBottomMenuCharactersText,
            backgroundColor: AppColors.mainDark,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: AppTexts.mainBottomMenuEpisodesText,
            backgroundColor: AppColors.mainDark,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: AppTexts.mainBottomMenuLocationText,
            backgroundColor: AppColors.mainDark,
          ),
        ],
      ),
    );
  }
}
