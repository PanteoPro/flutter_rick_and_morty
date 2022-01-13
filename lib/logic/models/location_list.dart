import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/location.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/my_app.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/navigation/main_navigation.dart';

class LocationListModel extends ChangeNotifier {
  final _locations = <Location>[];
  var _filteredLocations = <Location>[];
  List<Location> get filteredLocations => List.unmodifiable(_filteredLocations);

  final searchTextController = TextEditingController();

  Future<void> init() async {
    _loadLocations();
    searchTextController.addListener(_search);
    _filteredLocations = _locations;
  }

  void _search() {
    final query = searchTextController.text.toLowerCase();
    _filteredLocations = _locations.where((element) => element.name.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  void onLocationTap(Location location, BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.locationDetail, arguments: location);
  }

  Future<void> _loadLocations() async {
    _locations.clear();
    try {
      final locationBox = Hive.box<Location>(MyAppModel.locationBoxName);
      _locations.addAll(locationBox.values.toList());
      notifyListeners();
    } catch (e) {}
  }

  void showLocationAtIndex(int index) {
    if (index == _locations.length - 3) {
      // loadLocations();
    }
  }
}
