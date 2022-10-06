import 'package:botcasts/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:botcasts/models/app_user.dart';

import 'package:botcasts/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../utils/user.dart';

class EditName extends StatelessWidget {
  // mock user list
  UserMock userList;

  EditName({
    Key? key,
    required this.userList,
  }) : super(key: key);

  late AppUser user;
  TextEditingController username = TextEditingController();

  void changeUsername(BuildContext context, email, profilePicUrl) async {}

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser>(context);
    BlocProvider.of<UserDetailBloc>(context)
        .add(RequestUserDetailEvent(user.uid));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'ชื่อ',
        ),
        iconTheme: IconThemeData(color: white),
        actions: [
          BlocBuilder<UserDetailBloc, UserDetailState>(
            builder: ((context, state) {
              if (state is UserDetailFinished) {
                return IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: 'save',
                  onPressed: () async {
                    await DatabaseService(uid: user.uid).updateUserDetail(
                      username.text.trim(),
                      state.user.email,
                      state.user.profilePicUrl,
                    );

                    BlocProvider.of<UserDetailBloc>(context)
                        .add(RequestUserDetailEvent(user.uid));
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: 'save',
                  onPressed: () {},
                );
              }
            }),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            // text field title
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'ชื่อ',
                style: TextStyle(fontSize: 16),
              ),
            ),
            // text field for name
            TextFormField(
              controller: username, // using for clear text field
              maxLength: 100,
              decoration: InputDecoration(
                // labelText: 'ชื่อ',
                // labelStyle: TextStyle(
                //   color: white,
                // ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: white),
                ),
                hintText: 'กรุณาใส่ชื่อ',
                hintStyle: TextStyle(color: grey),
                counterStyle: TextStyle(color: grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    username.clear();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
