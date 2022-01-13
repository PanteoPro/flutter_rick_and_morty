import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/constants.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/widgets/auth/auth_header_form_widget.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          const AuthHeaderFormWidget(),
          const SizedBox(height: 25),
          const Text(AppTexts.authTextFirst, style: textStyle),
          const SizedBox(height: 25),
          const Text(
            AppTexts.authTextSecond,
            style: textStyle,
          ),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.lightButton,
            child: const Text(AppTexts.authRegisterButtonText),
          ),
        ],
      ),
    );
  }
}
