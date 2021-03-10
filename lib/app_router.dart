import 'package:FlutterGalleryApp/pages/home/home.dart';
import 'package:FlutterGalleryApp/pages/home/screens/profile_screen.dart';
import 'package:FlutterGalleryApp/pages/login/login.dart';
import 'package:FlutterGalleryApp/pages/photo/photo.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static FluroRouter router = FluroRouter();

  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return HomePage();
    },
  );

  static Handler _loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LoginPage();
    },
  );

  static Handler _photoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return PhotoPage();
    },
  );

  static Handler _profileHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return ProfileScreen(key: PageStorageKey("${params['id'][0]}"));
    },
  );

  static void setupRouter() {
    router.define(
      HomePage.routeName,
      handler: _homeHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      LoginPage.routeName,
      handler: _loginHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      PhotoPage.routeName,
      handler: _photoHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      "${ProfileScreen.routeName}/:id",
      handler: _profileHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}
