import 'package:FlutterGalleryApp/pages/login/login.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatefulWidget {
  LikeButton({this.photo, Key key}) : super(key: key);

  final Photo photo;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  UnsplashStore _unsplashStore;

  @override
  Widget build(BuildContext context) {
    _unsplashStore = Provider.of<UnsplashStore>(context);

    return Observer(
      builder: (_) => GestureDetector(
        onTap: () {
          if (!_unsplashStore.authStore.signedIn) {
            Navigator.pushNamed(context, LoginPage.routeName);
          } else {
            if (widget.photo.likedByUser) {
              widget.photo.unlike();
            } else {
              widget.photo.like();
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                widget.photo.likedByUser ? AppIcons.like_fill : AppIcons.like,
                size: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(widget.photo.likes.toString())
            ],
          ),
        ),
      ),
    );
  }
}
