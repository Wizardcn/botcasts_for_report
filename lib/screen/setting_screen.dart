// import 'dart:async';

import 'package:botcasts/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:botcasts/screen/birthday_screen.dart';
import 'package:botcasts/screen/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../utils/user.dart';

class MySettingScreen extends StatefulWidget {
  @override
  const MySettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MySettingScreenstate createState() {
    return _MySettingScreenstate();
  }
}

class _MySettingScreenstate extends State<MySettingScreen> {
  // list of mock data
  List<UserMock> userList = UserMock.myUser();
  String selectedLang = 'ไทย';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGreyColor,
        elevation: 0,
        centerTitle: true,
        title: const Image(
          image: AssetImage('assets/logo/Font.png'),
          height: 25,
        ),
        iconTheme: IconThemeData(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // account setting
            ListTile(
              leading: const Icon(Icons.person_rounded),
              iconColor: white,
              title: const Text('จัดการบัญชี'),
            ),
            // divider
            Divider(
              color: white,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            // account details
            ListTile(
              leading: const Text('อีเมล'),
              iconColor: white,
              title: Container(
                alignment: Alignment.centerRight,
                child: BlocBuilder<UserDetailBloc, UserDetailState>(
                  builder: ((context, state) {
                    if (state is UserDetailLoading ||
                        state is UserDetailInitial) {
                      return Text(
                        "กำลังโหลด",
                        style: TextStyle(color: grey, fontSize: 15),
                      );
                    }
                    if (state is UserDetailFinished) {
                      return Text(
                        // user email here
                        state.user.email,
                        style: TextStyle(color: grey, fontSize: 15),
                      );
                    } else {
                      return Column();
                    }
                  }),
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: white),
            ),
            ListTile(
              leading: const Text('วันเดือนปีเกิด'),
              iconColor: white,
              title: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  // user date of birth here
                  userList[1].bod,

                  style: TextStyle(color: grey, fontSize: 15),
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BdScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Text('รหัสผ่าน'),
              iconColor: white,
              trailing: Icon(Icons.arrow_forward_ios, color: white),
            ),
            ListTile(
              leading: const Text('หมายเลขโทรศัพท์'),
              iconColor: white,
              title: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  // user phone number here
                  userList[1].phoneNum,
                  style: TextStyle(color: grey, fontSize: 15),
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: white),
            ),

            // language setting
            ListTile(
              leading: const Icon(Icons.translate_rounded),
              iconColor: white,
              title: const Text('ภาษา'),
            ),
            //divider
            Divider(
              color: white,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            // language details
            ListTile(
              leading: const Text('ภาษา'),
              iconColor: white,
              onTap: () async {
                final data = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguagePage(),
                  ),
                );
                // print(data);
                setState(
                  () {
                    selectedLang = data;
                  },
                );
              },
              title: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  //selected language here
                  selectedLang, style: TextStyle(color: grey, fontSize: 15),
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: white),
            ),

            // privacy policy setting
            ListTile(
              leading: const Icon(Icons.insert_drive_file_rounded),
              iconColor: white,
              title: const Text('นโยบายความเป็นส่วนตัว'),
            ),
            //divider
            Divider(
              color: white,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            // privacy policy details
            ListTile(
              leading: const Text('นโยบายความเป็นส่วนตัว'),
              iconColor: white,
              trailing: Icon(Icons.arrow_forward_ios, color: white),
            ),
          ],
        ),
      ),
    );
  }
}
