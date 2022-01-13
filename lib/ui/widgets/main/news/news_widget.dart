import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_unofficial_wiki/logic/models/my_app.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/resources.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MyAppModel>(context);
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            const Image(
              image: AssetImage(AppImages.mainBackground),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(
                color: Colors.black
                    .withAlpha(model!.isLoadProgress || model.isErrorInLoading || model.isEmptyBoxes ? 150 : 0)),
            Column(
              children: const [
                SizedBox(height: 30),
                Image(
                  image: AssetImage(AppImages.rickAndMortyTitle2),
                ),
              ],
            ),
            if (model.isLoadProgress)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.loadProgressMessage,
                      style: const TextStyle(color: Color.fromRGBO(167, 233, 255, 1), fontSize: 30),
                    ),
                    const SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(250, 255, 91, 1),
                      ),
                    ),
                  ],
                ),
              ),
            if (model.isErrorInLoading || model.isEmptyBoxes)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Произошла какая то ошибка при загрузке.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color.fromRGBO(167, 233, 255, 1), fontSize: 22),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: model.loadData,
                        child: const Text('Загрузить данные'),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
