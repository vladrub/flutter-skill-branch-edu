import 'package:FlutterGalleryApp/pages/login/login.dart';
import 'package:FlutterGalleryApp/store/auth_store.dart';
import 'package:FlutterGalleryApp/store/connectivity_store.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:FlutterGalleryApp/pages/home/screens/profile_screen.dart';
import 'package:FlutterGalleryApp/pages/home/screens/search_screen.dart';
import 'package:FlutterGalleryApp/pages/home/screens/feed_screen.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../widgets/widgets.dart';
import '../../res/res.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityStore _connectivityStore;
  AuthStore _authStore;
  ReactionDisposer _disposer;

  int currentTab = 0;

  List<Widget> pages = [
    FeedScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _connectivityStore = Provider.of<ConnectivityStore>(context);
    _authStore = Provider.of<AuthStore>(context);

    _disposer = reaction(
      (_) => _connectivityStore.connectivityStream.value,
      (result) => (result == ConnectivityResult.none)
          ? ConnectivityOverlay().showOverlay(context)
          : ConnectivityOverlay().removeOverlay(context),
      delay: 4000,
    );

    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 8,
        curve: Curves.ease,
        onItemSelected: (int index) {
          if (index == 2 && !_authStore.signedIn) {
            Navigator.pushNamed(context, LoginPage.routeName).then((value) {
              if (value) {
                setState(() {
                  currentTab = index;
                });
              }
            });
          } else {
            setState(() {
              currentTab = index;
            });
          }
        },
        currentTab: currentTab,
        items: [
          BottomNavyBarItem(
            asset: AppIcons.gallery,
            title: Text('Home'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
          BottomNavyBarItem(
            asset: AppIcons.search,
            title: Text('Search'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
          BottomNavyBarItem(
            asset: AppIcons.user,
            title: Text('Profile'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          )
        ],
      ),
      body: pages[currentTab],
    );
  }
}
