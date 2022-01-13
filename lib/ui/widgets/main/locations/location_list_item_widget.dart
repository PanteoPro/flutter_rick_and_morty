import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/Theme/app_colors.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/location.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/location_list.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/constants.dart';

class LocationListItemWidget extends StatelessWidget {
  const LocationListItemWidget({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<LocationListModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.mainCard,
                border: Border.all(color: Colors.black.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _NameWidget(location: location),
                  const SizedBox(height: 10),
                  const Text(
                    AppTexts.mainLocationsListTypeText,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  _TypeWidget(location: location),
                  const SizedBox(height: 15),
                  const Text(
                    AppTexts.mainLocationsListDimensionText,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  _DimensionWidget(location: location),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => model?.onLocationTap(location, context),
            ),
          ),
        ],
      ),
    );
  }
}

class _DimensionWidget extends StatelessWidget {
  const _DimensionWidget({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Text(
      location.dimension == '' ? AppTexts.mainLocationsListDimensionEmptyText : location.dimension,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}

class _TypeWidget extends StatelessWidget {
  const _TypeWidget({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Text(
      location.type,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Text(
      location.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
