import 'package:botcasts/screen/auth/login_screen.dart';
import 'package:botcasts/screen/auth/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  bool showLogInPage;

  AuthPage({Key? key, required this.showLogInPage}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void toggleScreens() {
    setState(() {
      widget.showLogInPage = !widget.showLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showLogInPage) {
      return LoginPage(showSignUpPage: toggleScreens);
    } else {
      return SignUpPage(showLogInPage: toggleScreens);
    }
  }
}
