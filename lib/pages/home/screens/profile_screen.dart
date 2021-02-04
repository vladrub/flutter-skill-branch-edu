import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/store/auth_store.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  AuthStore _authStore;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Observer(
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileInfo(),
              SizedBox(height: 20),
              _buildBiography(),
              SizedBox(height: 30),
              _buildTabs()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAvatar(
            avatarLink:
                'https://avatars2.githubusercontent.com/u/4814848?s=460&u=fa13ef42405f5e5b048aab53e80e612d0cfa198c&v=4',
            width: 75,
            height: 75,
          ),
          SizedBox(width: 18),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Dianne Miles',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            '2654',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      color: AppColors.dodgerBlue,
                                      letterSpacing: -0.47,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'followers',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.08,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            '15',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      color: AppColors.dodgerBlue,
                                      letterSpacing: -0.47,
                                    ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'following',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      letterSpacing: -0.08,
                                    ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      AppIcons.location,
                      size: 14,
                      color: AppColors.dodgerBlue,
                    ),
                    SizedBox(width: 7),
                    Text(
                      '114 West Market,  Bloomington, MN',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            letterSpacing: -0.08,
                          ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      AppIcons.link,
                      size: 14,
                      color: AppColors.dodgerBlue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'www.diannemiles9000.com',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            letterSpacing: -0.08,
                          ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiography() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ExpandableText(
        'Non sit veniam minim cupidatat labore duis laboris consectetur excepteur nulla nostrud nostrud sint ipsum. Deserunt non tempor consequat Lorem occaecat magna occaecat aute labore Non sit veniam minim cupidatat labore duis laboris consectetur excepteur nulla nostrud nostrud sint ipsum. Deserunt non tempor consequat Lorem occaecat magna occaecat aute labore ',
        trimLines: 3,
        buttonStyle: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
        textStyle: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.w300,
              color: AppColors.black,
            ),
      ),
    );
  }

  Widget _buildTabs() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            border: Border(
              bottom: BorderSide(color: AppColors.gray, width: 1),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Icon(AppIcons.home, size: 20),
              Icon(AppIcons.like, size: 20),
              Icon(AppIcons.bookmark_empty, size: 20),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 300,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueGrey[300],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueGrey[300],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueGrey[300],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        PopupMenuButton(
          onSelected: (val) async {
            if (val == 'logout') {
              await _authStore.signOut();
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
    );
  }
}
