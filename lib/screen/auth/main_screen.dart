import 'package:botcasts/bloc/content_types_bloc/content_types_bloc.dart';
import 'package:botcasts/bloc/contents_bloc/contents_bloc.dart';
import 'package:botcasts/navigate_pages.dart';
import 'package:botcasts/screen/auth/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ContentTypesBloc>(context).add(RequestContentTypesEvent());
    BlocProvider.of<ContentsBloc>(context).add(AppStartUpEvent());
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else if (snapshot.hasData) {
            return const NavigatePages();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
