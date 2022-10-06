import 'package:botcasts/models/contents.dart';
import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final Content content;
  final double cardHeight;
  final double cardWidth;
  final double textHeight;
  final double textWidth;
  final double spaceBetweenImageAndText;

  const ContentCard({
    Key? key,
    required this.content,
    required this.spaceBetweenImageAndText,
    required this.cardHeight,
    required this.cardWidth,
    required this.textHeight,
    required this.textWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: cardHeight,
          width: cardWidth,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        SizedBox(
          height: spaceBetweenImageAndText,
        ),
        SizedBox(
          height: textHeight,
          width: textWidth,
          child: Text(
            content.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
