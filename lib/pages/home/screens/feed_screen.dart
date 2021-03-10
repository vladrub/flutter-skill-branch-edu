import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/pages/home/screens/profile_screen.dart';
import 'package:FlutterGalleryApp/pages/photo/photo.dart';
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

  void fetchPhotos() async {
    await _unsplashStore.photosStore.fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    _unsplashStore = Provider.of<UnsplashStore>(context);
    fetchPhotos();

    return Scaffold(
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: _unsplashStore.photosStore.photos.length,
          itemBuilder: (BuildContext context, int index) {
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
        );
      }),
    );
  }

  Widget _buildItem(Photo photo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: Hero(
            tag: 'photo-${photo.id}',
            child: RoundedPhoto(photo: photo),
          ),
        ),
        _buildPhotoMeta(photo),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: AppColors.black),
          ),
        )
      ],
    );
  }

  Widget _buildPhotoMeta(Photo photo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                SizedBox(width: 6),
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
          LikeButton(
            likeCount: 101,
            isLiked: true,
          )
        ],
      ),
    );
  }
}
