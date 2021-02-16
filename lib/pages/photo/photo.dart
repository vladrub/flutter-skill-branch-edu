import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';

class PhotoPageArguments {
  PhotoPageArguments({
    this.altDescription,
    this.heroTag,
    this.userName,
    this.name,
    this.photo,
    this.userPhoto,
    this.routeSettings,
    this.key,
  });

  final String altDescription;
  final String heroTag;
  final String userName;
  final String name;
  final String photo;
  final String userPhoto;
  final RouteSettings routeSettings;
  final Key key;
}

class PhotoPage extends StatefulWidget {
  static const routeName = '/photo';

  PhotoPage({Key key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> with TickerProviderStateMixin {
  AnimationController _controller;
  PhotoPageArguments _photoPageArguments;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _photoPageArguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Hero(
            tag: _photoPageArguments.heroTag,
            child: RoundedPhoto(photoLink: _photoPageArguments.photo),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              _photoPageArguments.altDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: AppColors.black),
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
                    _customButton(
                      'Save',
                      () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Download photos'),
                          content: Text(
                              'Are you sure you want to download a photo?'),
                          actions: [
                            FlatButton(
                              onPressed: () async {
                                GallerySaver.saveImage(
                                        'https://image.shutterstock.com/image-photo/montreal-canada-july-11-2019-600w-1450023539.jpg')
                                    .then((bool success) {
                                  setState(() {
                                    print('Image is saved');
                                  });
                                });
                              },
                              child: Text('Download'),
                            ),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Close'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    _customButton(
                      'Visit',
                      () async {
                        OverlayState overlayState = Overlay.of(context);
                        OverlayEntry overlayEntry =
                            OverlayEntry(builder: (BuildContext context) {
                          return Positioned(
                            top: MediaQuery.of(context).viewInsets.top + 50,
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.mercury,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text('test'),
                                ),
                              ),
                            ),
                          );
                        });

                        overlayState.insert(overlayEntry);
                        await Future.delayed(Duration(seconds: 1));
                        overlayEntry.remove();
                      },
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () async {
            String claim = await showModalBottomSheet(
              context: context,
              builder: (context) => ClaimBottomSheet(),
            );

            print(claim);
          },
        )
      ],
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Photo'),
    );
  }

  Widget _customButton(label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.white),
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
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              final Animation<double> opacity1 = Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    0.0,
                    0.5,
                    curve: Curves.ease,
                  ),
                ),
              );

              final Animation<double> opacity2 = Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    0.5,
                    1.0,
                    curve: Curves.ease,
                  ),
                ),
              );

              return Row(
                children: [
                  Opacity(
                    opacity: opacity1.value,
                    child: UserAvatar(
                      avatarLink: _photoPageArguments.userPhoto,
                    ),
                  ),
                  SizedBox(width: 6),
                  Opacity(
                    opacity: opacity2.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _photoPageArguments.name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          _photoPageArguments.heroTag,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: AppColors.manatee),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
