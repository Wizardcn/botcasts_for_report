import 'package:flutter/material.dart';
import '../constants.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          // language title
          const ListTile(
            title: Text(
              'ภาษา',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          //divider
          Divider(
            color: grey,
            thickness: 3,
            indent: 5,
            endIndent: 5,
          ),
          // Thai language
          ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: SizedBox(
              width: 50,
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Flag_of_Thailand.svg/255px-Flag_of_Thailand.svg.png'),
            ),
            title: const Text('ไทย'),
            onTap: () {
              Navigator.pop(context, 'ไทย');
            },
          ),
          //divider
          Divider(
            color: grey,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          // UK language
          ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_the_United_Kingdom_%282-3%29.svg/2560px-Flag_of_the_United_Kingdom_%282-3%29.svg.png'),
            ),
            title: const Text('English (UK)'),
            onTap: () {
              Navigator.pop(context, 'UK');
            },
          ),
          //divider
          Divider(
            color: grey,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          // USA language
          ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                  'https://cdn.britannica.com/79/4479-050-6EF87027/flag-Stars-and-Stripes-May-1-1795.jpg'),
            ),
            title: const Text('English (USA)'),
            onTap: () {
              Navigator.pop(context, 'USA');
            },
          ),
        ],
      ),
    );
  }
}
