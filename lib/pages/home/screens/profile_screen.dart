import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/store/unsplash/profile_store.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key key,
    this.showBackButton = false,
    this.userName,
  }) : super(key: key);

  final bool showBackButton;
  final String userName;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  UnsplashStore _unsplashStore;
  TabController _tabController;
  ScrollController _scrollViewController;

  final GlobalKey<RefreshIndicatorState> refresh2 =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollViewController = ScrollController();

    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          break;
        case 1:
          _unsplashStore.profileStore.fetchProfileLikedPhotos();
          break;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  void fetchProfile() async {
    await _unsplashStore.profileStore.fetchProfile(userName: widget.userName);
  }

  void fetchProfileLikedPhotos() async {
    await _unsplashStore.profileStore.fetchProfileLikedPhotos();
  }

  @override
  Widget build(BuildContext context) {
    _unsplashStore = Provider.of<UnsplashStore>(context);
    fetchProfile();

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              forceElevated: boxIsScrolled,
              elevation: 0.0,
              leading: (widget.showBackButton)
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : null,
              actions: [
                PopupMenuButton(
                  onSelected: (val) async {
                    if (val == 'logout') {
                      await _unsplashStore.authStore.signOut();
                      Navigator.pushNamed(context, '/');
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        value: 'logout',
                        child: Text('Logout'),
                      )
                    ];
                  },
                ),
              ],
              title: Text('Profile'),
            ),
            SliverToBoxAdapter(
              child: _buildProfile(),
            ),
            SliverPersistentHeader(
              delegate: _SliverTabBarDelegate(
                _buildTabBar(),
              ),
              pinned: true,
            ),
          ];
        },
        body: _buildTabs(),
        // body: CustomScrollView(slivers: [
        //   // SliverOverlapInjector(
        //   //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        //   // ),
        //   SliverToBoxAdapter(
        //     child: _buildTabs(),
        //   ),
        // ]),
      ),
    );
  }

  Widget _buildProfile() {
    return Observer(builder: (_) {
      if (_unsplashStore.profileStore.state == ProfileStoreState.loaded) {
        return ProfileInfo(profile: _unsplashStore.profileStore.profile);
      } else {
        return Loader();
      }
    });
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(icon: Icon(AppIcons.home, size: 20)),
        Tab(icon: Icon(AppIcons.like, size: 20)),
        Tab(icon: Icon(AppIcons.bookmark_empty, size: 20)),
      ],
    );
  }

  TabBarView _buildTabs() {
    return TabBarView(
      controller: _tabController,
      children: [
        Container(
          child: Observer(builder: (_) {
            if (_unsplashStore.profileStore.photosState ==
                ProfileStoreState.loaded) {
              return ProfilePhotosGrid(
                _unsplashStore.profileStore.profile.photos,
                () {
                  return Future.delayed(Duration(seconds: 2), () {});
                },
              );
            } else {
              return Loader();
            }
          }),
        ),
        Container(
          child: Observer(builder: (_) {
            if (_unsplashStore.profileStore.likedPhotosState ==
                ProfileStoreState.loaded) {
              return ProfilePhotosGrid(
                _unsplashStore.profileStore.profile.likedPhotos,
                () async {
                  await _unsplashStore.profileStore
                      .fetchProfileLikedPhotos(reload: true);
                },
              );
            } else {
              return Loader();
            }
          }),
        ),
        Container(
          color: AppColors.manatee,
          child: Text('Tab #3'),
        ),
      ],
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
