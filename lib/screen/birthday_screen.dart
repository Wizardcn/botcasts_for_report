import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import '../constants.dart';

class BdScreen extends StatefulWidget {
  const BdScreen({Key? key}) : super(key: key);
  @override
  State<BdScreen> createState() => _BdScreenState();
}

class _BdScreenState extends State<BdScreen> {
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
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              'วันเดือนปีเกิด',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
