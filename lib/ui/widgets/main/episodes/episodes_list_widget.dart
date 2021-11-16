import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_app/Theme/app_colors.dart';
import 'package:rick_and_morty_app/logic/models/episode_list.dart';
import 'package:rick_and_morty_app/resources/constants.dart';
import 'package:rick_and_morty_app/ui/widgets/main/episodes/episode_list_item_widget.dart';

class EpisodeListWidget extends StatelessWidget {
  const EpisodeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<EpisodeListModel>(context);
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
              itemExtent: 160,
              itemBuilder: (ctx, index) {
                model.showEpisodeAtIndex(index);
                final episode = model.filteredCharacters[index];
                return EpisodesListItem(episode: episode);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: model.searchTextController,
            decoration: InputDecoration(
              labelText: AppTexts.mainEpisodesListSearchText,
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
