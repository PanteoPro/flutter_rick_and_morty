import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty_app/logic/domain/api/api_client.dart';
import 'package:rick_and_morty_app/logic/domain/data_providers/session_data_provider.dart';
import 'package:rick_and_morty_app/resources/constants.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;
  bool get canAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    final isEmptyFields = login.isEmpty || password.isEmpty;

    if (isEmptyFields) {
      _errorMessage = AppTexts.authErrorMessageEmptyText;
      notifyListeners();
    } else {
      _errorMessage = null;
      _isAuthProgress = true;
      notifyListeners();
      try {
        await _apiClient.login(login: login, password: password);
      } on ApiClientException catch (e) {
        switch (e.type) {
          case ApiClientExceptionType.Network:
            _errorMessage = AppTexts.authErrorMessageBadNetworkText;
            break;
          case ApiClientExceptionType.Auth:
            _errorMessage = AppTexts.authErrorMessageBadLoginText;
            break;
          case ApiClientExceptionType.Other:
            _errorMessage = AppTexts.authErrorMessageUnknownText;
            break;
        }
      }
      _isAuthProgress = false;
      if (_errorMessage == null) {
        await _sessionDataProvider.setSessionId('some_token');
        Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen);
      } else {
        notifyListeners();
      }
    }
  }

  Future<void> register(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    final isEmptyFields = login.isEmpty || password.isEmpty;

    if (isEmptyFields) {
      _errorMessage = AppTexts.authErrorMessageEmptyText;
      notifyListeners();
    } else {
      _errorMessage = null;
      _isAuthProgress = true;
      notifyListeners();
      try {
        await _apiClient.register(login: login, password: password);
      } on ApiClientException catch (e) {
        switch (e.type) {
          case ApiClientExceptionType.Network:
            _errorMessage = AppTexts.authErrorMessageBadNetworkText;
            break;
          case ApiClientExceptionType.Auth:
            _errorMessage = AppTexts.authErrorMessageBadLoginText;
            break;
          case ApiClientExceptionType.Other:
            _errorMessage = AppTexts.authErrorMessageUnknownText;
            break;
        }
      }
      _isAuthProgress = false;
      if (_errorMessage == null) {
        await _sessionDataProvider.setSessionId('some_token');
        Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen);
      } else {
        notifyListeners();
      }
    }
  }
}

// class AuthProvider extends InheritedNotifier<AuthModel> {
//   AuthProvider({
//     Key? key,
//     required Widget child,
//     required AuthModel model,
//   }) : super(key: key, notifier: model, child: child);

//   static AuthModel? watch(BuildContext context) {
//     final provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//     final notifier = provider?.notifier;
//     return notifier;
//   }

//   static AuthModel? read(BuildContext context) {
//     final element = context.getElementForInheritedWidgetOfExactType<AuthProvider>();
//     final provider = element?.widget as AuthProvider;
//     final notifier = provider.notifier;
//     return notifier;
//   }
// }

