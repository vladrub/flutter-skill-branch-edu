import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';

class RoundedPhoto extends StatelessWidget {
  const RoundedPhoto({
    this.photo,
    Key key,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    final double widthContainer = MediaQuery.of(context).size.width;
    final double heightContainer = (photo.width != null && photo.height != null)
        ? (widthContainer / photo.width) * photo.height
        : null;

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        child: Container(
          color: AppColors.grayChateau,
          child: CachedNetworkImage(
            imageUrl: photo.urls.regular,
            width: widthContainer,
            height: heightContainer,
            fit: BoxFit.cover,
            placeholder: (context, url) => Loader(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
