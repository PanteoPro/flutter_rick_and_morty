import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_app/logic/domain/entity/character.dart';
import 'package:rick_and_morty_app/logic/domain/entity/episode.dart';
import 'package:rick_and_morty_app/logic/domain/entity/location.dart';
import 'package:rick_and_morty_app/logic/models/auth.dart';
import 'package:rick_and_morty_app/logic/models/detail_character.dart';
import 'package:rick_and_morty_app/logic/models/detail_episode.dart';
import 'package:rick_and_morty_app/logic/models/detail_location.dart';
import 'package:rick_and_morty_app/ui/pages/auth_page.dart';
import 'package:rick_and_morty_app/ui/pages/detail_character_page.dart';
import 'package:rick_and_morty_app/ui/pages/detail_episode_page.dart';
import 'package:rick_and_morty_app/ui/pages/detail_location_page.dart';
import 'package:rick_and_morty_app/ui/pages/main_page.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const characterDetail = '/character_detail';
  static const episodeDetail = '/episode_detail';
  static const locationDetail = '/location_detail';
}

class MainNavigation {
  // String initialRoute(bool isAuth) => isAuth ? MainNavigationRouteNames.mainScreen : MainNavigationRouteNames.auth;
  String initialRoute(bool isAuth) => MainNavigationRouteNames.mainScreen;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) => NotifierProvider(
          model: AuthModel(),
          child: const AuthPage(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => const MainPage(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.characterDetail:
        final arguments = settings.arguments;
        final character = arguments is Character ? arguments : null;
        final model = DetailCharacterModel(character: character);
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            model: model,
            child: const DetailCharacterPage(),
          ),
        );
      case MainNavigationRouteNames.episodeDetail:
        final arguments = settings.arguments;
        final episode = arguments is Episode ? arguments : null;
        final model = DetailEpisodeModel(episode: episode)..init();
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            model: model,
            child: const DetailEpisodePage(),
          ),
        );
      case MainNavigationRouteNames.locationDetail:
        final arguments = settings.arguments;
        final location = arguments is Location ? arguments : null;
        final model = DetailLocationModel(location: location)..init();
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            model: model,
            child: const DetailLocationPage(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Text('Navigation Error!'));
    }
  }
}
