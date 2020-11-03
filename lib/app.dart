import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:connectivity/connectivity.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: buildAppTextTheme(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) =>
            Home(Connectivity().onConnectivityChanged),
        '/photo': (BuildContext context) => FullScreenImage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              (settings.arguments as FullScreenImageArguments);

          final route = FullScreenImage(
            altDescription: args.altDescription,
            heroTag: args.heroTag,
            userName: args.userName,
            name: args.name,
            photo: args.photo,
            userPhoto: args.userPhoto,
            key: args.key,
          );

          return CupertinoPageRoute(
              builder: (context) => route, settings: args.routeSettings);
        }
      },
      initialRoute: '/',
      // home: FeedScreen(),
    );
  }
}
