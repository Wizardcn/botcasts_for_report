import 'package:flutter/material.dart';

class SlideItem extends StatefulWidget {
  final String img;
  final String title;
  final String author;
  final String category;

  const SlideItem ({
    Key? key,
    required this.img,
    required this.title,
    required this.author,
    required this.category,
  }) : super(key: key);

  @override
  State<SlideItem> createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  ),
              child: Image.asset(
                widget.img,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 100,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
