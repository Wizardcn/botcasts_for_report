import 'package:botcasts/bloc/app_bloc_observer.dart';
import 'package:botcasts/bloc/content_types_bloc/content_types_bloc.dart';
import 'package:botcasts/bloc/contents_bloc/contents_bloc.dart';
import 'package:botcasts/bloc/profile_pict_uploader_bloc/profile_pict_uploader_bloc.dart';
import 'package:botcasts/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:botcasts/constants.dart';
import 'package:botcasts/models/app_user.dart';
import 'package:botcasts/screen/auth/main_screen.dart';
import 'package:botcasts/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDetailBloc = BlocProvider<UserDetailBloc>(
      create: (context) => UserDetailBloc(),
    );
    final contentsBloc = BlocProvider<ContentsBloc>(
      create: (context) => ContentsBloc(),
    );
    final contentTypesBloc = BlocProvider<ContentTypesBloc>(
      create: (context) => ContentTypesBloc(),
    );
    final profilePictUploaderBloc = BlocProvider<ProfilePictUploaderBloc>(
      create: (context) => ProfilePictUploaderBloc(),
    );

    return MultiBlocProvider(
      providers: [
        userDetailBloc,
        contentsBloc,
        contentTypesBloc,
        profilePictUploaderBloc,
      ],
      child: StreamProvider<AppUser?>.value(
        initialData: null,
        value: AuthService().user,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: bgDarkColor,
            textTheme: ThaiFonts.promptTextTheme(
              Theme.of(context).textTheme.apply(
                    displayColor: Colors.white,
                    bodyColor: Colors.white,
                  ),
            ),
          ),
          home: const MainPage(),
        ),
      ),
    );
  }
}
