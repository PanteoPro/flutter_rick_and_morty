import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_app/Theme/app_colors.dart';
import 'package:rick_and_morty_app/logic/domain/entity/episode.dart';
import 'package:rick_and_morty_app/logic/models/episode_list.dart';
import 'package:rick_and_morty_app/resources/constants.dart';

class EpisodesListItem extends StatelessWidget {
  final Episode episode;
  const EpisodesListItem({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<EpisodeListModel>(context);
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
                  _NameWidget(episode: episode),
                  const SizedBox(height: 10),
                  const Text(
                    AppTexts.mainEpisodesListOutDateText,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  _DateWidget(episode: episode),
                  const SizedBox(height: 15),
                  const Text(
                    AppTexts.mainEpisodesListEpisodeNameText,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  _EpisodeWidget(episode: episode),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => model?.onEpisodeTap(episode, context),
            ),
          ),
        ],
      ),
    );
  }
}

class _EpisodeWidget extends StatelessWidget {
  const _EpisodeWidget({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Text(
      episode.episode,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}

class _DateWidget extends StatelessWidget {
  const _DateWidget({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Text(
      episode.air_date,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Text(
      episode.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
