import 'package:botcasts/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:botcasts/constants.dart';

import 'package:botcasts/shared/user_loading.dart';
import 'package:botcasts/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_profile/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenstate();
  }
}

class _ProfileScreenstate extends State<ProfileScreen> {
  // list of mock data
  List<UserMock> userList = UserMock.myUser();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 15),
        child: Column(
          children: [
            BlocBuilder<UserDetailBloc, UserDetailState>(
              builder: ((context, state) {
                if (state is UserDetailLoading || state is UserDetailInitial) {
                  return const UserLoading();
                }
                if (state is UserDetailFinished) {
                  return Column(
                    children: [
                      // profile pic
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(state.user.profilePicUrl),
                      ),

                      const SizedBox(height: 15),

                      // username display
                      Text(
                        state.user.username,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                } else {
                  return Column();
                }
              }),
            ),

            const SizedBox(height: 15),

            //edit profile button
            SizedBox(
              height: 40,
              width: 130,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: white),
                    ),
                  ),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                ),
                child: const Text(
                  "แก้ไขโปรไฟล์",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // user description
            Text(
              userList[1].about,
              style: TextStyle(fontSize: 15, color: grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // divider
            Divider(
              color: white,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),

            // my podcast display
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                'พอดแคสต์ของฉัน',
                style: TextStyle(fontSize: 15, color: white),
                textAlign: TextAlign.left,
              ),
            ),
            // TODO content card on profile screen
            // Expanded(
            //   child: Container(
            //     padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            //     child: GridView.builder(
            //       itemCount: userList[1].audioList.length,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3,
            //         childAspectRatio: w / (h / 1.2),
            //         crossAxisSpacing: 20,
            //       ),
            //       itemBuilder: (BuildContext context, int index) => ContentCard(
            //         content: userList[1].audioList[index],
            //         spaceBetweenImageAndText: 5,
            //         cardHeight: 200,
            //         cardWidth: 200,
            //         textHeight: 50,
            //         textWidth: 150,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
