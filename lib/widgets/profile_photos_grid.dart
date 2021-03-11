import 'package:FlutterGalleryApp/extensions/hex_color.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/pages/photo/photo.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePhotosGrid extends StatefulWidget {
  ProfilePhotosGrid(
      {this.photos, this.onRefresh, this.onShowMore, this.showLoader, Key key})
      : super(key: key);

  final List<Photo> photos;
  final VoidCallback onRefresh;
  final VoidCallback onShowMore;
  final bool showLoader;

  @override
  _ProfilePhotosGridState createState() => _ProfilePhotosGridState();
}

class _ProfilePhotosGridState extends State<ProfilePhotosGrid> {
  final GlobalKey<RefreshIndicatorState> refresh =
      GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        widget.onShowMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refresh,
      onRefresh: widget.onRefresh,
      child: Container(
        child: (widget.photos.length != 0)
            ? GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                children: widget.photos
                    .map((Photo photo) => _buildPhoto(photo))
                    .toList(),
              )
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: 300,
                  child: Center(
                    child: Text('No content yet'),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildPhoto(Photo photo) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        PhotoPage.routeName,
        arguments:
            PhotoPageArguments(photo: photo, heroTag: 'photo-${photo.id}'),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        child: Container(
          color: AppColors.grayChateau,
          child: Hero(
            tag: 'photo-${photo.id}',
            child: CachedNetworkImage(
              imageUrl: '${photo.urls.regular}',
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
      ),
    );
  }
}
