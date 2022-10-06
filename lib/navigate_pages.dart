import 'package:botcasts/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:botcasts/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:botcasts/constants.dart';
import 'package:botcasts/screen/home_page.dart';
import 'package:botcasts/screen/user_profile/profile_screen.dart';
import 'package:botcasts/screen/search_screen.dart';
import 'package:botcasts/screen/favorite_screen.dart';
import 'package:botcasts/screen/history_screen.dart';
import 'package:botcasts/screen/setting_screen.dart';
import 'package:botcasts/utils/user.dart';
import 'package:botcasts/shared/user_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NavigatePages extends StatefulWidget {
  // pass mock user list from other pages
  // AudsMock audioNav;
  const NavigatePages({
    Key? key,
    // required this.audioNav,
  }) : super(key: key);

  @override
  State<NavigatePages> createState() => _NavigatePagesState();
}

class _NavigatePagesState extends State<NavigatePages> {
  // final user = FirebaseAuth.instance.currentUser!;
  late AppUser? user;
  // Store all page
  late List<Widget> _pages;
  // define widget of each page
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late Widget _page4;
  late Widget _page5;

  // mock user list
  List<UserMock> userList = UserMock.myUser();

  // variable use for handle state nav
  late int _currentIndex;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    // call each page
    _page1 = const HomePage();
    _page2 = SearchPage();
    _page3 = const ProfileScreen();
    _page4 = const MyFavorite();
    _page5 = const MyHistory();
    _pages = [_page1, _page2, _page3, _page4, _page5];
    _currentIndex = 0;
    _currentPage = _page1;
  }

  // Function handle change state of navbar
  void _changeTab(int _index) {
    setState(
      () {
        int diff = 0;
        _currentIndex = _index;
        // print(_currentIndex % 3 + 1);
        _currentPage = _pages[_index];
        if (_currentIndex >= 3) {
          diff = _currentIndex % 3 + 1;
          // print(diff);
          _currentIndex = _currentIndex - diff;
        }
        // print(_currentIndex);
      },
    );
  }

  // for ui and navigate on drawer
  Widget _navigationItemSideBar(String _title, IconData _icon, int _index) {
    return ListTile(
      leading: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (blend) => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [pinkColor, purpleColor],
        ).createShader(blend),
        child: Icon(_icon, color: white, size: 35),
      ),
      title: Text(
        _title,
        style: const TextStyle(fontSize: 18),
      ),
      onTap: () {
        Navigator.pop(context);
        _changeTab(_index + 3);
      },
    );
  }

  Widget userDetail() {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: ((context, state) {
        if (state is UserDetailLoading || state is UserDetailInitial) {
          return const UserLoading();
        }
        if (state is UserDetailFinished) {
          return Column(
            children: [
              const SizedBox(height: 30),
              CircleAvatar(
                backgroundImage: NetworkImage(state.user.profilePicUrl),
                radius: 50,
              ),
              const SizedBox(height: 20),
              Text(
                state.user.username,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Padding(
                //padding in case email is toooo long
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  state.user.email,
                  // userList[1].email,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return Column();
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    BlocProvider.of<UserDetailBloc>(context)
        .add(RequestUserDetailEvent(user?.uid));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGreyColor,
        elevation: 0,
        centerTitle: true,
        title: const Image(
          image: AssetImage('assets/logo/Font.png'),
          height: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MySettingScreen()));
            },
            icon: const Icon(
              Icons.settings,
              size: 25,
            ),
          ),
        ],
        iconTheme: IconThemeData(color: white),
      ),

      // drawer start here
      drawer: Drawer(
        child: Container(
          color: bgDarkColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Column(
              children: [
                userDetail(),

                // divider for seperate profile and list of nav
                Divider(
                  color: grey,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 10),

                // nav list start here
                _navigationItemSideBar('รายการโปรด', Icons.favorite, 0),
                _navigationItemSideBar('ประวัติการเข้าชม', Icons.history, 1),

                // logout tile
                ListTile(
                  leading: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (blend) => LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [pinkColor, purpleColor],
                    ).createShader(blend),
                    child: Icon(Icons.logout_rounded, color: white, size: 35),
                  ),
                  title: const Text(
                    'ออกจากระบบ',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),

                // display present version
                // Text(
                //   'version 10.20.30.40',
                //   textAlign: TextAlign.center,
                // ),
                // Text(
                //   'credit',
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
          ),
        ),
      ),

      // bottom nav start here
      //version 2
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, //set current index
        onTap: (index) {
          // nav to other page
          _changeTab(index);
        },
        selectedItemColor: pinkColor,
        // selectedLabelStyle: TextStyle(color: white),
        unselectedItemColor: white,
        backgroundColor: bgGreyColor,
        showUnselectedLabels: false,
        selectedFontSize: 13,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'ค้นหา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'ฉัน',
          ),
        ],
      ),

      //version 1
      // bottomNavigationBar: GNav(
      //   // bottom nav
      //   backgroundColor: bgGreyColor, // background color
      //   // rippleColor: Colors.grey[400]!, // tab button ripple color when pressed
      //   curve: Curves.easeInExpo, // tab animation curves
      //   color: iconColor, // default icon color
      //   textStyle: TextStyle(color: white),
      //   activeColor: pinkColor, // color when icon was selected
      //   gap: 15, //gap between icons
      //   iconSize: 25, //icon size
      //   onTabChange: (index) {
      //     //nav to other page
      //     _changeTab(index);
      //   },
      //   selectedIndex: _currentIndex,
      //   padding: const EdgeInsets.symmetric(
      //       horizontal: 40, vertical: 25), // navigation bar padding
      //   tabs: const [
      //     GButton(
      //       icon: Icons.home_rounded,
      //       text: 'หน้าหลัก',
      //     ),
      //     GButton(
      //       icon: Icons.play_circle_fill_rounded,
      //       text: 'เล่น',
      //     ),
      //     GButton(
      //       icon: Icons.account_circle_rounded,
      //       text: 'ฉัน',
      //     ),
      //   ],
      // ),

      // navigate to each page but change only body part
      body: Center(
        child: _currentPage,
      ),
    );
  }
}
