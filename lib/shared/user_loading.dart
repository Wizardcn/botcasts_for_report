import 'package:botcasts/shared/constants.dart';
import 'package:botcasts/shared/custom_icon.dart';
import 'package:flutter/material.dart';

class UserLoading extends StatelessWidget {
  const UserLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            primary: grey,
            shape: const CircleBorder(),
            backgroundColor: blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              Icons.person,
              size: 50,
              color: white,
            ),
          ),
        ),
        const Text(
          "กำลังโหลด",
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
