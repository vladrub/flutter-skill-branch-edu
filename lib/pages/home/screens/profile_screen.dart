import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/store/unsplash/profile_store.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:FlutterGalleryApp/widgets/profile_collections_grid.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileScreenArguments {
  ProfileScreenArguments({
    this.routeSettings,
    this.heroTag,
    this.userName,
  });

  final String heroTag;
  final String userName;
  final RouteSettings routeSettings;
}

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  ProfileScreen({
    Key key,
    this.userName,
  }) : super(key: key);

  final String userName;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  ProfileScreenArguments _photoPageArguments;
  UnsplashStore _unsplashStore;
  TabController _tabController;
  ScrollController _scrollViewController;
  String _userName;

  @override
  void initState() {
    if (_photoPageArguments != null) {
      _userName = _photoPageArguments.userName;
    }
    _tabController = TabController(length: 3, vsync: this);
    _scrollViewController = ScrollController();

    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          break;
        case 1:
          if (_unsplashStore.profileStore.profile.likedPhotos == null &&
              _unsplashStore.profileStore.likedPhotosState !=
                  ProfileStoreState.loading) {
            _unsplashStore.profileStore.fetchProfileLikedPhotos();
          }
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

  @override
  Widget build(BuildContext context) {
    _unsplashStore = Provider.of<UnsplashStore>(context);
    fetchProfile();

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollViewController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            elevation: 0.0,
            leading: (_userName != null)
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : null,
            actions: [
              if (_userName == null)
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
            floating: false,
          ),
          SliverFillRemaining(
            child: _buildTabs(),
          )
        ],
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
        Observer(builder: (_) {
          if (_unsplashStore.profileStore.profile != null &&
              _unsplashStore.profileStore.profile.photos != null) {
            return ProfilePhotosGrid(
              photos: _unsplashStore.profileStore.profile.photos,
              onRefresh: () async {
                await _unsplashStore.profileStore
                    .fetchProfilePhotos(reFresh: true);
              },
              onShowMore: () {
                if (_unsplashStore.profileStore.photosState !=
                        ProfileStoreState.loading &&
                    !_unsplashStore.profileStore.profile.photosIsLastPage) {
                  _unsplashStore.profileStore.fetchProfilePhotos();
                }
              },
            );
          } else {
            return Loader();
          }
        }),
        Observer(builder: (_) {
          print(_unsplashStore.profileStore.profile.likedPhotos);
          if (_unsplashStore.profileStore.profile.likedPhotos != null) {
            return ProfilePhotosGrid(
              photos: _unsplashStore.profileStore.profile.likedPhotos,
              onRefresh: () async {
                await _unsplashStore.profileStore
                    .fetchProfileLikedPhotos(reFresh: true);
              },
              showLoader:
                  !_unsplashStore.profileStore.profile.likedPhotosIsLastPage,
              onShowMore: () {
                if (_unsplashStore.profileStore.likedPhotosState !=
                        ProfileStoreState.loading &&
                    !_unsplashStore
                        .profileStore.profile.likedPhotosIsLastPage) {
                  _unsplashStore.profileStore.fetchProfileLikedPhotos();
                }
              },
            );
          } else {
            return Loader();
          }
        }),
        Observer(builder: (_) {
          print(_unsplashStore.profileStore.profile.collections);
          if (_unsplashStore.profileStore.profile.collections != null) {
            return ProfileCollectionsGrid(
              collections: _unsplashStore.profileStore.profile.collections,
              onRefresh: () async {
                await _unsplashStore.profileStore
                    .fetchProfileCollections(reFresh: true);
              },
              showLoader:
                  !_unsplashStore.profileStore.profile.collectionsIsLastPage,
              onShowMore: () {
                if (_unsplashStore.profileStore.collectionsState !=
                        ProfileStoreState.loading &&
                    !_unsplashStore
                        .profileStore.profile.collectionsIsLastPage) {
                  _unsplashStore.profileStore.fetchProfileCollections();
                }
              },
            );
          } else {
            return Loader();
          }
        }),
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
