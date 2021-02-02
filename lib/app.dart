import 'package:FlutterGalleryApp/pages/home/home.dart';
import 'package:FlutterGalleryApp/pages/login/login.dart';
import 'package:FlutterGalleryApp/pages/photo/photo.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/store/connectivity/connectivity_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final ConnectivityStore _connectivityStore = ConnectivityStore();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ConnectivityStore>(create: (_) => _connectivityStore),
      ],
      child: MaterialApp(
        title: 'Skill-branch course work',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: buildAppTextTheme(),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: <String, WidgetBuilder>{
          // '/': (BuildContext context) => HomePage(),
          '/': (BuildContext context) => LoginPage(),
          '/photo': (BuildContext context) => PhotoPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/fullScreenImage') {
            PhotoPageArguments args =
                (settings.arguments as PhotoPageArguments);

            final route = PhotoPage(
              altDescription: args.altDescription,
              heroTag: args.heroTag,
              userName: args.userName,
              name: args.name,
              photo: args.photo,
              userPhoto: args.userPhoto,
              key: args.key,
            );

            return CupertinoPageRoute(
              builder: (context) => route,
              settings: args.routeSettings,
            );
          }
        },
        initialRoute: '/',
      ),
    );
  }
}
