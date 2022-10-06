import 'package:botcasts/models/contents.dart';
import 'package:botcasts/screen/audio_screen.dart';
import 'package:botcasts/shared/content_card.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class ContentBar extends StatelessWidget {
  final String category;
  final List<Content> contentList;
  final double spaceBetween;
  const ContentBar({
    Key? key,
    required this.category,
    required this.contentList,
    this.spaceBetween = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                capitalize(category),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spaceBetween),
        Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: ListView.builder(
              itemCount: contentList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AudioScreen(
                          content: contentList[index],
                          // idAud: index,
                        ),
                      ),
                    );
                  },
                  child: ContentCard(
                    content: contentList[index],
                    spaceBetweenImageAndText: 10,
                    cardHeight: 200,
                    cardWidth: 200,
                    textHeight: 50,
                    textWidth: 150,
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
