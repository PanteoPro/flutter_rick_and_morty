import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Library/Widgets/Inherited/provider.dart';
import 'package:rick_and_morty_app/logic/models/auth.dart';
import 'package:rick_and_morty_app/resources/constants.dart';

class AuthHeaderFormWidget extends StatelessWidget {
  const AuthHeaderFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );
    const inputDecoration = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessageWidget(),
        const Text(AppTexts.authLoginText, style: textStyle),
        const SizedBox(height: 5),
        TextField(
          controller: model?.loginTextController,
          decoration: inputDecoration,
        ),
        const SizedBox(height: 20),
        const Text(AppTexts.authPasswordText, style: textStyle),
        const SizedBox(height: 5),
        TextField(
          controller: model?.passwordTextController,
          decoration: inputDecoration,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const _LoginButtonWidget(),
            const SizedBox(width: 10),
            const _RegisterButtonWidget(),
            const SizedBox(width: 10),
            // TextButton(
            //   onPressed: () {},
            //   style: AppButtonStyle.lightButton,
            //   child: const Text(AppTexts.authResetPasswordButtonText),
            // ),
          ],
        ),
      ],
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    final onPressed = model?.canAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            height: 20,
            width: 20,
            child: const CircularProgressIndicator(
              color: Color.fromRGBO(238, 191, 112, 1),
            ),
          )
        : const Text(AppTexts.authLoginButtonText);

    return TextButton(
      onPressed: onPressed,
      style: AppButtonStyle.bigButton,
      child: child,
    );
  }
}

class _RegisterButtonWidget extends StatelessWidget {
  const _RegisterButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    final onPressed = model?.canAuth == true ? () => model?.register(context) : null;
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            height: 20,
            width: 20,
            child: const CircularProgressIndicator(
              color: Color.fromRGBO(158, 238, 140, 1),
            ),
          )
        : const Text(AppTexts.authRegisterButtonText);

    return TextButton(
      onPressed: onPressed,
      style: AppButtonStyle.bigButton,
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = NotifierProvider.watch<AuthModel>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 17,
        ),
      ),
    );
  }
}
