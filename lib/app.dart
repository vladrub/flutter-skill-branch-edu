import 'package:flutter/material.dart';
import 'package:galleryapp/screens/feed_screen.dart';
import 'package:galleryapp/screens/photo_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => FeedScreen(),
        '/photo': (BuildContext context) => FullScreenImage(
            name: 'Vladislav Rubanovich',
            userName: '@rubdev',
            altDescription: 'asdasd'),
      },
      initialRoute: '/',
      // home: FeedScreen(),
    );
  }
}
