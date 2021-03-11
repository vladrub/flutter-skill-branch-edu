import 'package:FlutterGalleryApp/extensions/hex_color.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';

class RoundedPhoto extends StatelessWidget {
  const RoundedPhoto({
    this.photo,
    this.borderRadius = 17.0,
    Key key,
  }) : super(key: key);

  final Photo photo;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final double widthContainer = MediaQuery.of(context).size.width;
    final double heightContainer = (photo.width != null && photo.height != null)
        ? (widthContainer / photo.width) * photo.height
        : null;

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: Container(
          color: AppColors.grayChateau,
          child: CachedNetworkImage(
            imageUrl: photo.urls.regular,
            width: widthContainer,
            height: heightContainer,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: (photo.color != null)
                  ? HexColor.fromHex(photo.color)
                  : Colors.transparent,
              child: Loader(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
