import 'package:botcasts/utils/my_audio.dart';

class UserMock {
  String img;
  String name;
  String email;
  String about;
  String bod;
  String phoneNum;
  List<Audio> audioList;

  UserMock(
    this.img,
    this.name,
    this.email,
    this.about,
    this.bod,
    this.phoneNum,
    this.audioList,
  );

  static List<UserMock> myUser() {
    return [
      UserMock(
        'assets/img/userimg1.jpg',
        'Yuta Okkotsu',
        'goodbyeRika@gmail.com',
        'I’ll give you my future, heart, and body… I love you Rika… This is pure love.',
        '05 มกราคม ค.ศ. 2001',
        '+66900000000',
        [
          Audio(
            'assets/contents/1.jpg',
            'Happy Jones',
          ),
          Audio(
            'assets/contents/2.jpg',
            'Life Planned',
          ),
          Audio(
            'assets/contents/3.jpg',
            'Find Me Interesting',
          ),
          Audio(
            'assets/contents/4.jpg',
            'Promise You Will Keep',
          ),
          Audio(
            'assets/contents/5.jpg',
            'Happy Jones',
          ),
          Audio(
            'assets/contents/6.jpg',
            'Happy Jones',
          ),
          Audio(
            'assets/contents/7.jpg',
            'Happy Jones',
          ),
          Audio(
            'assets/contents/8.jpg',
            'Happy Jones',
          ),
          Audio(
            'assets/contents/9.jpg',
            'Happy Jones',
          ),
          Audio(
            'assets/contents/10.jpg',
            'Happy Jones',
          ),
        ],
      ),
      UserMock(
        'assets/img/userimg2.jpg',
        'Killua Zoldyck',
        'killuagonforeverr@gmail.com',
        'You don’t need to thank friends.',
        '07 กรกฎาคม ค.ศ. 1987',
        '+66900000000',
        [
          Audio(
            'assets/contents/kl1.jpg',
            'Tired Of Killing',
          ),
          Audio(
            'assets/contents/kl4.jpg',
            'Promise Me',
          ),
          Audio(
            'assets/contents/kl7.jpg',
            'Gon’s Suffering',
          ),
          Audio(
            'assets/contents/kl8.jpg',
            'Life Planned',
          ),
          Audio(
            'assets/contents/kl5.jpg',
            'Forgiveness',
          ),
          Audio(
            'assets/contents/kl6.jpg',
            'Complacent',
          ),
          Audio(
            'assets/contents/kl3.jpg',
            'Find Me Interesting',
          ),
          Audio(
            'assets/contents/kl2.jpg',
            'Ran Away',
          ),
        ],
      )
    ];
  }
}
