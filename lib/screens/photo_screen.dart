import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:galleryapp/res/res.dart';
import 'package:galleryapp/widgets/widgets.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    this.altDescription = 'Description',
    this.userName = '@kaparray',
    this.heroTag = 'tag',
    this.name = 'Name',
    this.photo = 'https://picsum.photos/900/600',
    this.userPhoto =
        'https://avatars2.githubusercontent.com/u/4814848?s=460&u=fa13ef42405f5e5b048aab53e80e612d0cfa198c&v=4',
    Key key,
  }) : super(key: key);

  final String altDescription;
  final String heroTag;
  final String userName;
  final String name;
  final String photo;
  final String userPhoto;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.black26,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Photo',
            style: AppStyles.h1Black,
          ),
          centerTitle: true,
          elevation: 0,
          bottomOpacity: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Hero(
              tag: widget.heroTag,
              child: Photo(photoLink: widget.photo),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                widget.altDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h3.copyWith(color: AppColors.black),
              ),
            ),
            _buildPhotoMeta(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 105,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LikeButton(
                              likeCount: 2157,
                              isLiked: false,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      _customButton('Save', () {
                        print('asd');
                      })
                    ],
                  ),
                  Column(
                    children: [
                      _customButton('Visit', () {
                        print('asd');
                      })
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _customButton(label, onTap) {
    return GestureDetector(
      onTap: () => onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: 105,
          height: 36,
          color: AppColors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppStyles.h4.copyWith(color: AppColors.white),
              )
            ],
          ),
        ),
      ),
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
                avatarLink: widget.userPhoto,
              ),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: AppStyles.h2Black,
                  ),
                  Text(
                    widget.heroTag,
                    style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
