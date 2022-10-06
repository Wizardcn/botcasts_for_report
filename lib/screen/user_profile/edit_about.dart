import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../utils/user.dart';

class EditAbout extends StatelessWidget {
  UserMock userList;

  EditAbout({
    Key? key,
    required this.userList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController clearBox = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('ประวัติ'),
        iconTheme: IconThemeData(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            // text field title
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'ประวัติ',
                style: TextStyle(fontSize: 16),
              ),
            ),
            // text field for about me
            TextField(
              controller: clearBox, // using for clear text field
              maxLength: 100,
              decoration: InputDecoration(
                // labelText: 'ประวัติ',
                // labelStyle: TextStyle(
                // color: white,
                // ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: white),
                ),
                hintText: 'กรุณาใส่ประวัติ',
                hintStyle: TextStyle(color: grey),
                counterStyle: TextStyle(color: grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    clearBox.clear();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: white,
                    size: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
