import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/Theme/app_colors.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/detail_episode.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/widgets/main/episodes/detail/detail_episode_header_widget.dart';

class DetailEpisodePage extends StatelessWidget {
  const DetailEpisodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailEpisodeModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(model?.episode?.name ?? 'Not find'), // name of episode
      ),
      body: ColoredBox(
        color: AppColors.mainBackgroundCard,
        child: ListView(
          children: [
            const DetailEpisodeHeaderWidget(),
          ],
        ),
      ),
    );
  }
}
