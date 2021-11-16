import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_app/Theme/app_colors.dart';
import 'package:rick_and_morty_app/logic/models/detail_location.dart';
import 'package:rick_and_morty_app/ui/widgets/main/locations/detail/detail_location_header_widget.dart';

class DetailLocationPage extends StatelessWidget {
  const DetailLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailLocationModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(model?.location?.name ?? 'Not find'), // name of episode
      ),
      body: ColoredBox(
        color: AppColors.mainBackgroundCard,
        child: ListView(
          children: [
            const DetailLocationHeaderWidget(),
          ],
        ),
      ),
    );
  }
}
