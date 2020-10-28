import 'package:flutter/material.dart';
import 'package:galleryapp/res/res.dart';
import 'package:galleryapp/screens/photo_screen.dart';
import 'package:galleryapp/widgets/widgets.dart';

const String kFlutterDash = 'https://picsum.photos/900/600';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            _buildItem(index),
            Divider(
              thickness: 2.0,
              color: AppColors.mercury,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildItem(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return FullScreenImage(
                heroTag: 'hero$index',
              );
            }));
          },
          child: Hero(
            tag: 'hero$index',
            child: Photo(photoLink: kFlutterDash),
          ),
        ),
        _buildPhotoMeta(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3.copyWith(color: AppColors.black),
          ),
        )
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserAvatar(
                avatarLink:
                    'https://avatars2.githubusercontent.com/u/4814848?s=460&u=fa13ef42405f5e5b048aab53e80e612d0cfa198c&v=4',
              ),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vladislav Rubanovich',
                    style: AppStyles.h2Black,
                  ),
                  Text(
                    '@rubdev',
                    style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                  )
                ],
              )
            ],
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
