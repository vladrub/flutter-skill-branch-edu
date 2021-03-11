import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/pages/home/screens/profile_screen.dart';
import 'package:FlutterGalleryApp/pages/photo/photo.dart';
import 'package:FlutterGalleryApp/store/unsplash/photos_store.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

const String kFlutterDash = 'https://picsum.photos/900/600';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  UnsplashStore _unsplashStore;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if (_unsplashStore.photosStore.state != PhotosStoreState.loading) {
          _unsplashStore.photosStore.fetchPhotos();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void fetchPhotos() async {
    if (_unsplashStore.photosStore.photos.length == 0)
      await _unsplashStore.photosStore.fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    _unsplashStore = Provider.of<UnsplashStore>(context);
    fetchPhotos();

    return Scaffold(
      body: Observer(builder: (_) {
        if (_unsplashStore.photosStore.photos.length != 0) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              _unsplashStore.photosStore.fetchPhotos(reFresh: true);
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _unsplashStore.photosStore.photos.length,
              itemBuilder: (BuildContext context, int index) {
                if (index + 1 == _unsplashStore.photosStore.photos.length) {
                  return Center(
                    child: Loader(),
                  );
                }
                return Column(
                  children: [
                    _buildItem(_unsplashStore.photosStore.photos[index]),
                    Divider(
                      thickness: 2.0,
                      color: AppColors.mercury,
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Center(
            child: Loader(),
          );
        }
      }),
    );
  }

  Widget _buildItem(Photo photo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              PhotoPage.routeName,
              arguments: PhotoPageArguments(
                  photo: photo, heroTag: 'photo-${photo.id}'),
            ),
            child: Hero(
              tag: 'photo-${photo.id}',
              child: RoundedPhoto(photo: photo),
            ),
          ),
        ),
        _buildPhotoMeta(photo),
        if (photo.description != null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              photo.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 20 / 14),
            ),
          )
      ],
    );
  }

  Widget _buildPhotoMeta(Photo photo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProfileScreen(
                    userName: photo.profile.username,
                    key: PageStorageKey("profile-${photo.profile.id}"),
                  ),
                ),
              );
            },
            child: Row(
              children: [
                UserAvatar(
                  avatarLink: (photo.profile.profileImage.medium != null)
                      ? photo.profile.profileImage.medium
                      : photo.profile.profileImage.small,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      photo.profile.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      "@${photo.profile.username}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: AppColors.manatee),
                    )
                  ],
                )
              ],
            ),
          ),
          LikeButton(photo: photo)
        ],
      ),
    );
  }
}
