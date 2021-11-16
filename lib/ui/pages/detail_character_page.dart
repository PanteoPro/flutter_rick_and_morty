import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_app/Theme/app_colors.dart';
import 'package:rick_and_morty_app/logic/models/detail_character.dart';
import 'package:rick_and_morty_app/ui/widgets/main/characters/detail/detail_character_header_widget.dart';

class DetailCharacterPage extends StatelessWidget {
  const DetailCharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailCharacterModel>(context);
    final character = model?.character;

    return Scaffold(
      appBar: AppBar(
        title: Text(character?.name ?? 'Not found'), // name of character
      ),
      body: ColoredBox(
        color: AppColors.mainBackgroundCard,
        child: ListView(
          children: [
            const DetailCharacterHeaderWidget(),
          ],
        ),
      ),
    );
  }
}
