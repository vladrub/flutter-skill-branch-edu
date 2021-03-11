import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/pages/home/screens/profile_screen.dart';
import 'package:FlutterGalleryApp/store/unsplash/photos_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:FlutterGalleryApp/extensions/format_date.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoPageArguments {
  PhotoPageArguments({this.routeSettings, this.photo, this.heroTag});

  final String heroTag;
  final Photo photo;
  final RouteSettings routeSettings;
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

    if (_photoPageArguments.photo.relatedPhotosState ==
        PhotosStoreState.initial)
      _photoPageArguments.photo.fetchRelatedPhotos();

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
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
                            userName:
                                _photoPageArguments.photo.profile.username,
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
                  SizedBox(height: 20),
                ],
              ),
            ),
            _buildRelatedPhotos()
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
                children: [
                  if (_photoPageArguments.photo.likedByUser != null)
                    LikeButton(photo: _photoPageArguments.photo)
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            PhotoButton(
              label: 'Save',
              onTap: () => _showDialogSave(_photoPageArguments.photo.urls.full),
            )
          ],
        ),
        Column(
          children: [
            PhotoButton(
              label: 'Visit',
              onTap: () async {
                if (await canLaunch(_photoPageArguments.photo.urls.full)) {
                  await launch(
                    _photoPageArguments.photo.urls.full,
                    forceSafariVC: false,
                    forceWebView: false,
                  );
                } else {
                  throw 'Could not launch ${_photoPageArguments.photo.urls.full}';
                }
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _buildRelatedPhotos() {
    return Observer(
      builder: (_) {
        if (_photoPageArguments.photo.relatedPhotosState ==
            PhotosStoreState.loading) {
          return Center(
            child: Loader(),
          );
        }

        if (_photoPageArguments.photo.relatedPhotosState ==
                PhotosStoreState.loaded &&
            _photoPageArguments.photo.relatedPhotos.length == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('No related photos found.'),
            ),
          );
        }

        return GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.all(10),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: _photoPageArguments.photo.relatedPhotos
              .map((Photo photo) => RoundedPhoto(
                    photo: photo,
                    borderRadius: 7,
                  ))
              .toList(),
        );
      },
    );
  }

  Future<void> _showDialogSave(String image) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Download photos'),
        content: Text('Are you sure you want to download a photo?'),
        actions: [
          FlatButton(
            onPressed: () async {
              await GallerySaver.saveImage('$image.jpg').then((bool success) {
                Navigator.of(context).pop();
                _showDialogSuccess();
              }).catchError((_) {
                _showDialogError();
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
    );
  }

  Future<void> _showDialogSuccess() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Photo was successfully saved'),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogError() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Error occurred while saving photo'),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
