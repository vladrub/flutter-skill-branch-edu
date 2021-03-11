import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LikeButton extends StatefulWidget {
  LikeButton({this.photo, Key key}) : super(key: key);

  final Photo photo;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => GestureDetector(
        onTap: () {
          if (widget.photo.likedByUser) {
            widget.photo.unlike();
          } else {
            widget.photo.like();
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
