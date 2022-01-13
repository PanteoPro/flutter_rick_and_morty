import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/Theme/app_colors.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/character.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/character_list.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/constants.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;
  const CharacterListItem({Key? key, required this.character}) : super(key: key);

  // void _onCharacterTap(int characterId, BuildContext context) {
  //   Navigator.of(context).pushNamed(MainNavigationRouteNames.characterDetail, arguments: characterId);
  // }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<CharacterListModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
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
            child: Row(
              children: [
                // const Image(image: AssetImage(AppImages.characterPlaceholder)),
                Image.network(character.image),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      _NameWidget(character: character),
                      const SizedBox(height: 5),
                      _StatusWidget(character: character),
                      const SizedBox(height: 15),
                      const Text(
                        AppTexts.mainCharacterListLocationText,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      _LocationWidget(character: character),
                      const SizedBox(height: 15),
                      const Text(
                        AppTexts.mainCharacterListEpisodeText,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      _EpisodeWidget(character: character),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => model?.onCharacterTap(character, context),
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
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    final episodes = character.episodesRelation;
    if (episodes == null) return const Text('No data');
    return Text(
      episodes.first.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Text(
      character.location['name']!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}

class _StatusWidget extends StatelessWidget {
  const _StatusWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    final status = character.status + ' - ' + character.species;
    return Row(
      children: [
        _CircleStatus(status: character.status),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            status,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ],
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

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Text(
      character.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
