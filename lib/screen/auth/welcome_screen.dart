import 'package:botcasts/constants.dart';
import 'package:botcasts/screen/auth/auth_screen.dart';
// import 'package:botcasts/screen/auth/signup_screen.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  final style = const TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 200,
              width: 250,
              child: Image.asset(
                'assets/img/Logo_Botcasts.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthPage(
                                showLogInPage: true,
                              ),
                            ));
                      },
                      child: Container(
                        height: 44,
                        width: 305,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              colors: [purpleColor, pinkColor],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                        child: Center(
                          child: Text("เข้าสู่ระบบ",
                              style: ThaiFonts.prompt(textStyle: style)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthPage(showLogInPage: false),
                        ),
                      );
                    },
                    child: Container(
                      height: 44,
                      width: 305,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            colors: [purpleColor, pinkColor],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: Center(
                        child: Text(
                          "ลงทะเบียน",
                          style: ThaiFonts.prompt(textStyle: style),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
