import 'package:FlutterGalleryApp/extensions/hex_color.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCollectionsGrid extends StatefulWidget {
  ProfileCollectionsGrid(
      {this.collections,
      this.onRefresh,
      this.onShowMore,
      this.showLoader,
      Key key})
      : super(key: key);

  final List<Collection> collections;
  final VoidCallback onRefresh;
  final VoidCallback onShowMore;
  final bool showLoader;

  @override
  _ProfileCollectionsGridState createState() => _ProfileCollectionsGridState();
}

class _ProfileCollectionsGridState extends State<ProfileCollectionsGrid> {
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
        child: (widget.collections.length != 0)
            ? GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                children: widget.collections.map((Collection collection) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    child: Container(
                      color: AppColors.grayChateau,
                      child: CachedNetworkImage(
                        imageUrl: '${collection.coverPhoto.urls.regular}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: (collection.coverPhoto.color != null)
                              ? HexColor.fromHex(collection.coverPhoto.color)
                              : Colors.transparent,
                          child: Loader(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                }).toList(),
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
}
