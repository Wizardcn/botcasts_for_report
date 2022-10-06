import 'package:flutter/material.dart';
// import 'package:botnoiflix/models/watchlistModel.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({Key? key}) : super(key: key);
  @override
  State<MyFavorite> createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            child: const ListTile(
              title: Text('Favorite is coming soon'),
            ),
          ),
        ],
      ),
    );
  }
}
