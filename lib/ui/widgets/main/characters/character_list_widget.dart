import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_app/Theme/app_colors.dart';
import 'package:rick_and_morty_app/logic/models/character_list.dart';
import 'package:rick_and_morty_app/resources/constants.dart';
import 'package:rick_and_morty_app/ui/widgets/main/characters/character_list_item_widget.dart';

class CharacterListWidget extends StatelessWidget {
  const CharacterListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<CharacterListModel>(context);
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
              itemCount: model.filteredCharacters.length,
              itemExtent: 180,
              itemBuilder: (ctx, index) {
                model.showCharacterAtIndex(index);
                final character = model.filteredCharacters[index];
                return CharacterListItem(character: character);
              },
            ),
          ),
        ),
        Padding(
          // in future take out it to another widget with use inherited widget
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: model.searchTextController,
            decoration: InputDecoration(
              labelText: AppTexts.mainCharacterListSearchText,
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
