// import 'package:botcasts/screen/audioScreen.dart';
import 'package:botcasts/utils/my_audio.dart';
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  Audio audioDetails;

  MyCard({
    Key? key,
    required this.audioDetails,
  }) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            widget.audioDetails.img,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.audioDetails.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
