import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';

class LikeButton extends StatefulWidget {
  LikeButton({this.likeCount, this.isLiked, Key key}) : super(key: key);

  final int likeCount;
  final bool isLiked;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isLiked = !isLiked;
        if (isLiked) {
          likeCount++;
        } else {
          likeCount--;
        }

        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              isLiked ? AppIcons.like_fill : AppIcons.like,
              size: 16,
            ),
            SizedBox(
              width: 10,
            ),
            Text(likeCount.toString())
          ],
        ),
      ),
    );
  }
}
