import 'package:flutter/material.dart';

abstract class AppTexts {
  static const String authAppBarText = 'Авторизуйтесь в вашем аккаунте';
  static const String authTextFirst =
      'Добро пожаловать в приложение посвещенному на тематику Rick and morty, здесь вы сможете посмоотреть всех персонажей за все время и многое другое!';
  static const String authTextSecond = 'Чтобы пользоваться приложением - авторизуйтесь или зарегистрируйтесь';
  static const String authRegisterButtonText = 'Зарегистрироваться';
  static const String authLoginText = 'Логин';
  static const String authPasswordText = 'Пароль';
  static const String authLoginButtonText = 'Авторизоваться';
  static const String authResetPasswordButtonText = 'Сбросить пароль';
  static const String authErrorMessageEmptyText = 'Заполните логин и пароль';
  static const String authErrorMessageBadLoginText = 'Неверный логин или пароль';
  static const String authErrorMessageBadNetworkText = 'Сервер не доступен. Проверьте подключение к интернету';
  static const String authErrorMessageUnknownText = 'Неизвестная ошибка. Повторите попытку позже';

  static const String mainAppBarText = 'Рик и Морти Библиотека';
  static const String mainBottomMenuNewsText = 'Главная';
  static const String mainBottomMenuCharactersText = 'Персонажи';
  static const String mainBottomMenuEpisodesText = 'Эпизоды';
  static const String mainBottomMenuLocationText = 'Локации';

  static const String mainCharacterListSearchText = 'Поиск';
  static const String mainCharacterListLocationText = 'Последнее местоположение';
  static const String mainCharacterListEpisodeText = 'Первое появление';

  static const String mainEpisodesListSearchText = 'Поиск';
  static const String mainEpisodesListOutDateText = 'Дата выхода';
  static const String mainEpisodesListEpisodeNameText = 'Episode';

  static const String mainLocationsListSearchText = 'Поиск';
  static const String mainLocationsListTypeText = 'Тип локации';
  static const String mainLocationsListDimensionText = 'Измерение';
  static const String mainLocationsListDimensionEmptyText = '-';
}

abstract class AppButtonStyle {
  static final bigButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.blue),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
    ),
    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
  );
  static final lightButton = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.blue),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 14)),
  );
}
