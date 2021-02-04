import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key key,
    this.avatarLink,
    this.width = 40,
    this.height = 40,
  }) : super(key: key);

  final String avatarLink;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
        imageUrl: avatarLink,
        width: width,
        height: height,
        fit: BoxFit.fill,
      ),
    );
  }
}
