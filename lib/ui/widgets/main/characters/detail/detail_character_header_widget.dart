import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/episode.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/detail_character.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/resources.dart';

class DetailCharacterHeaderWidget extends StatelessWidget {
  const DetailCharacterHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TopPosterWidget(),
        const _TopDetailInfo(),
      ],
    );
  }
}

class _TopDetailInfo extends StatelessWidget {
  const _TopDetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailCharacterModel>(context);
    final character = model?.character;
    if (character == null) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                character.name,
                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _CircleStatus(status: character.status),
                const SizedBox(width: 5),
                Text('${character.status} - ${character.species}',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            Text('Пол - ${character.gender}', style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Откуда - ${character.origin["name"]}', style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Последнее местоположение - ${character.location["name"]}',
                style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 10),
            _EpisodesWidget(episodes: character.episodesRelation),
          ],
        ),
      ),
    );
  }
}

class _CircleStatus extends StatelessWidget {
  final String status;
  const _CircleStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    switch (status.toLowerCase()) {
      case 'alive':
        color = Colors.green;
        break;
      case 'dead':
        color = Colors.red;
        break;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color,
      ),
    );
  }
}

class _EpisodesWidget extends StatelessWidget {
  const _EpisodesWidget({Key? key, required this.episodes}) : super(key: key);

  final HiveList<Episode>? episodes;

  @override
  Widget build(BuildContext context) {
    final episodesWidgets = episodes?.map((Episode episode) => _EpisodeItemWidget(episode: episode)).toList();
    if (episodesWidgets == null) return const Text('No data');
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Эпизоды:', style: TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(height: 10),
          ...episodesWidgets
        ],
      ),
    );
  }
}

class _EpisodeItemWidget extends StatelessWidget {
  const _EpisodeItemWidget({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailCharacterModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 50,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        '${episode.episode}) ',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      // Text('Сезон ${episode.episodeNumber} серия ${episode.episodeSeries}) '),
                      Expanded(
                        child: Text(
                          episode.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => model?.onEpisodeTap(episode, context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailCharacterModel>(context);
    final character = model?.character;
    final imagePath = character?.image;
    return Stack(
      children: [
        const Image(
          image: AssetImage(AppImages.rickAndMortyBackground2),
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: double.infinity,
          height: 200,
        ),
        Positioned(
          child: imagePath != null
              ? Image.network(imagePath)
              : const Image(
                  image: AssetImage(AppImages.characterPlaceholder),
                ),
          left: 20,
          top: 20,
          bottom: 20,
        ),
      ],
    );
  }
}
