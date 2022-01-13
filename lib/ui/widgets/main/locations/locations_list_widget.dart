import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/Theme/app_colors.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/location_list.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/constants.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/widgets/main/locations/location_list_item_widget.dart';

class LocationListWidget extends StatelessWidget {
  const LocationListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<LocationListModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        ColoredBox(
          color: AppColors.mainBackgroundCard,
          child: Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 70),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: model.filteredLocations.length,
              itemExtent: 160,
              itemBuilder: (ctx, index) {
                model.showLocationAtIndex(index);
                final location = model.filteredLocations[index];
                return LocationListItemWidget(location: location);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: model.searchTextController,
            decoration: InputDecoration(
              labelText: AppTexts.mainLocationsListSearchText,
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
