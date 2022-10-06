import 'package:botcasts/bloc/profile_pict_uploader_bloc/profile_pict_uploader_bloc.dart';
import 'package:botcasts/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:botcasts/models/app_user.dart';
import 'package:botcasts/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'edit_about.dart';
import 'edit_name.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  late AppUser user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser>(context);
    // mock user list
    List<UserMock> userList = UserMock.myUser();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('แก้ไขโปรไฟล์'),
        iconTheme: IconThemeData(color: white),
      ),
      body: Column(
        children: [
          BlocBuilder<UserDetailBloc, UserDetailState>(
            builder: ((context, state) {
              if (state is UserDetailLoading || state is UserDetailInitial) {
                return TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: grey,
                    shape: const CircleBorder(),
                    backgroundColor: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: white,
                    ),
                  ),
                );
              }
              if (state is UserDetailFinished) {
                return
                    // display user picture
                    CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(state.user.profilePicUrl),
                );
              } else {
                return Column();
              }
            }),
          ),

          const SizedBox(height: 5),

          // edit picture button
          BlocBuilder<UserDetailBloc, UserDetailState>(
            builder: (context, state) {
              if (state is UserDetailLoading || state is UserDetailInitial) {
                return TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(white),
                  ),
                  // editPicture page is not avaliable yet
                  onPressed: () {},
                  child: const Text(
                    "แก้ไขรูป",
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else if (state is UserDetailFinished) {
                return TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(white),
                  ),
                  // editPicture page is not avaliable yet
                  onPressed: () async {
                    try {
                      XFile? pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile == null) return;
                      BlocProvider.of<ProfilePictUploaderBloc>(context)
                          .add(ProfilePictUploaderPressed(
                        uid: user.uid,
                        username: state.user.username,
                        email: state.user.email,
                        fileName: pickedFile.path,
                      ));
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: const Text(
                    "แก้ไขรูป",
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else {
                return Column();
              }
            },
          ),
          BlocListener<ProfilePictUploaderBloc, ProfilePictUploaderState>(
            listener: ((context, state) {
              if (state is UploadToDBFinished) {
                print("upload to db finished");
                BlocProvider.of<UserDetailBloc>(context)
                    .add(RequestUserDetailEvent(user.uid));
                BlocProvider.of<ProfilePictUploaderBloc>(context)
                    .add(ResetProfilePictUploader());
              }
            }),
            child: Container(),
          ),

          // text title
          ListTile(
            title: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'เกี่ยวกับคุณ',
              ),
            ),
          ),

          // divider
          Divider(
            color: white,
            height: 0,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          const SizedBox(height: 5),

          // listtile of edit setting
          Expanded(
            child: ListView(
              children: [
                // for name
                ListTile(
                  title: const Text('ชื่อ'),
                  subtitle: BlocBuilder<UserDetailBloc, UserDetailState>(
                    builder: ((context, state) {
                      if (state is UserDetailLoading ||
                          state is UserDetailInitial) {
                        return const Text(
                          "กำลังโหลด",
                          style: TextStyle(color: Colors.grey),
                        );
                      }
                      if (state is UserDetailFinished) {
                        return Text(
                          state.user.username,
                          style: TextStyle(color: grey),
                        );
                      } else {
                        return Column();
                      }
                    }),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: white),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditName(
                          userList: userList[1],
                        ),
                      ),
                    );
                  },
                ),
                // for about
                ListTile(
                  title: const Text(
                    'ประวัติ',
                  ),
                  subtitle: Text(
                    userList[1].about,
                    style: TextStyle(color: grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: white),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAbout(
                          userList: userList[1],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
