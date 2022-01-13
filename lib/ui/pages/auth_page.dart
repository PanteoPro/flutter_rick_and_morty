import 'package:flutter/material.dart';
import 'package:rick_and_morty_unofficial_wiki/resources/constants.dart';
import 'package:rick_and_morty_unofficial_wiki/ui/widgets/auth/auth_header_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.authAppBarText),
      ),
      body: ListView(
        children: const [
          AuthHeaderWidget(),
        ],
      ),
    );
  }
}
