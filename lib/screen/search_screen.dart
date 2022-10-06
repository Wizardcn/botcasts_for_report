import 'package:botcasts/constants.dart';
import 'package:botcasts/shared/category_card.dart';
import 'package:botcasts/utils/aud.dart';
import 'package:flutter/material.dart';
import '../utils/category.dart';

class SearchPage extends StatelessWidget {
  final controller = TextEditingController();
  List<AudsMock> audioList = AudsMock.myAuds();
  List<CategoryMock> categoryList = CategoryMock.categoryMockup();

  SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            // Textfield for search
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                filled: true,
                fillColor: bgGreyColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "ศิลปิน หรือ บอทแคสต์",
                hintStyle: TextStyle(color: white),
                suffixIcon: Icon(
                  Icons.search,
                  color: white,
                ),
              ),
            ),
          ),

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: audioList.length,
          //     itemBuilder: (context, index){
          //       final auds = audioList[index];

          //       return ListTile(
          //         leading: Image.network(
          //           auds.image,
          //           fit: BoxFit.fitHeight,
          //           width: 50,
          //           height: 50,
          //           ),
          //           title: Text(auds.title),
          //       );
          //     },
          //   ),
          // ),

          // category gridview
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: GridView.builder(
                itemCount: categoryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (BuildContext context, int index) => CategoryCard(
                  categoryDetails: categoryList[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchAud(String query) {
    final suggestions = audioList.where((auds) {
      final audTitle = auds.title.toLowerCase();
      final input = query.toLowerCase();

      return audTitle.contains(input);
    }).toList();
  }
}
