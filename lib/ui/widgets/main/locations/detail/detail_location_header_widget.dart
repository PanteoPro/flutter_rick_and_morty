import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/domain/entity/character.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/detail_location.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/resources.dart';

class DetailLocationHeaderWidget extends StatelessWidget {
  const DetailLocationHeaderWidget({Key? key}) : super(key: key);

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
    final model = NotifierProvider.watch<DetailLocationModel>(context);
    final location = model?.location;
    if (location == null) return const SizedBox.shrink();
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
                location.name,
                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text('Тип - ${location.type}', style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Измерение - ${location.dimension}', style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 20),
            _CharactersWidget(),
          ],
        ),
      ),
    );
  }
}

class _CharactersWidget extends StatelessWidget {
  _CharactersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailLocationModel>(context);
    final characters = model?.characters;
    if (characters == null) return const SizedBox.shrink();
    if (characters.isEmpty) return const SizedBox.shrink();
    ;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
              child: Text(
            'Персонажи',
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 10),
          SizedBox(
            height: 140,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: characters.length,
                itemExtent: 100,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  final character = characters[index];
                  return _CharacterCardWidget(character: character);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterCardWidget extends StatelessWidget {
  final Character character;
  const _CharacterCardWidget({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailLocationModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(character.image),
              const SizedBox(height: 10),
              Text(
                character.name,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => model?.onCharacterTap(character, context),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Image(
          image: AssetImage(AppImages.rickAndMortyBackground3),
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: double.infinity,
          height: 200,
        ),
      ],
    );
  }
}
