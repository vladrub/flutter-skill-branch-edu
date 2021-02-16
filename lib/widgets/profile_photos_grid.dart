import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePhotosGrid extends StatefulWidget {
  ProfilePhotosGrid(this.photos, this.onRefresh, {Key key}) : super(key: key);

  final List<Photo> photos;
  final VoidCallback onRefresh;

  @override
  _ProfilePhotosGridState createState() => _ProfilePhotosGridState();
}

class _ProfilePhotosGridState extends State<ProfilePhotosGrid> {
  final GlobalKey<RefreshIndicatorState> refresh =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refresh,
      onRefresh: widget.onRefresh,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: (widget.photos.length != 0)
            ? GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                physics: const AlwaysScrollableScrollPhysics(),
                children: widget.photos.map((Photo photo) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                    child: Container(
                      color: AppColors.grayChateau,
                      child: CachedNetworkImage(
                        imageUrl: '${photo.urls.regular}',
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                }).toList(),
              )
            : Center(child: Text('No content yet')),
      ),
    );
  }
}
