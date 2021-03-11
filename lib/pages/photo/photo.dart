import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/pages/home/screens/profile_screen.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:FlutterGalleryApp/extensions/format_date.dart';

class PhotoPageArguments {
  PhotoPageArguments({
    this.routeSettings,
    this.photo,
    this.heroTag,
    this.key,
  });

  final String heroTag;
  final Photo photo;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: _photoPageArguments.heroTag,
                child: RoundedPhoto(photo: _photoPageArguments.photo),
              ),
              SizedBox(height: 5),
              _buildPhotoMeta(),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen(
                        userName: _photoPageArguments.photo.profile.username,
                        key: PageStorageKey(
                            "profile-${_photoPageArguments.photo.profile.id}"),
                      ),
                    ),
                  );
                },
                child: _buildPhotoProfile(),
              ),
              SizedBox(height: 18),
              _buildControls(),
              SizedBox(height: 30),
            ],
          ),
        ),
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

  Widget _buildPhotoMeta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _photoPageArguments.photo.createdAt.toHumanDate(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: AppColors.darkGray, fontWeight: FontWeight.w400),
        ),
        if (_photoPageArguments.photo.description != null)
          Container(
            padding: EdgeInsets.only(top: 7),
            child: Text(
              _photoPageArguments.photo.description,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 20 / 14),
            ),
          ),
      ],
    );
  }

  Widget _buildPhotoProfile() {
    return AnimatedBuilder(
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
                avatarLink:
                    (_photoPageArguments.photo.profile.profileImage.medium !=
                            null)
                        ? _photoPageArguments.photo.profile.profileImage.medium
                        : _photoPageArguments.photo.profile.profileImage.small,
              ),
            ),
            SizedBox(width: 10),
            Opacity(
              opacity: opacity2.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _photoPageArguments.photo.profile.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    "@${_photoPageArguments.photo.profile.username}",
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
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              width: 105,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LikeButton(photo: _photoPageArguments.photo)],
              ),
            )
          ],
        ),
        Column(
          children: [
            PhotoButton(
              label: 'Save',
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Download photos'),
                  content: Text('Are you sure you want to download a photo?'),
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
            PhotoButton(
              label: 'Visit',
              onTap: () async {
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
    );
  }
}
