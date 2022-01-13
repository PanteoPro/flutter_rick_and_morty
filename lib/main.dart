import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/Theme/app_colors.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/my_app.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/navigation/main_navigation.dart';

Future<void> main() async {
  await Hive.initFlutter();

  final model = MyAppModel();
  // await model.checkAuth();

  await model.initHive();
  // await model.clearAll();
  model.loadData();
  final app = MyApp(model: model);
  runApp(app);
}

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  final MyAppModel model;

  const MyApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RickAndMorty App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.mainDark,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.mainDark,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
        routes: mainNavigation.routes,
        initialRoute: mainNavigation.initialRoute(model.isAuth),
        onGenerateRoute: mainNavigation.onGenerateRoute,
      ),
    );
  }
}
