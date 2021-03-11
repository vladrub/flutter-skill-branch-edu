import 'package:FlutterGalleryApp/pages/photo/photo.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CollectionPageArguments {
  CollectionPageArguments({this.routeSettings, this.collection});

  final Collection collection;
  final RouteSettings routeSettings;
}

class CollectionPage extends StatefulWidget {
  CollectionPage({Key key}) : super(key: key);

  static const routeName = '/collection';

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  CollectionPageArguments _collectionPageArguments;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if (_collectionPageArguments.collection.photosState !=
            CollectionStoreState.loading) {
          _collectionPageArguments.collection.fetchPhotos();
        }
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
    _collectionPageArguments = ModalRoute.of(context).settings.arguments;

    if (_collectionPageArguments.collection.photosState ==
        CollectionStoreState.initial)
      _collectionPageArguments.collection.fetchPhotos();

    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Observer(builder: (_) {
          if (_collectionPageArguments.collection.photosState ==
                  CollectionStoreState.loading &&
              _collectionPageArguments.collection.photos.length == 0) {
            return Center(
              child: Loader(),
            );
          }

          if (_collectionPageArguments.collection.photos.length == 0) {
            return Center(
              child: Text('Nothing found.'),
            );
          }

          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              _collectionPageArguments.collection.fetchPhotos(reFresh: true);
            },
            child: GridView.builder(
              itemCount: _collectionPageArguments.collection.photos.length + 1,
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (_collectionPageArguments.collection.photosState ==
                        CollectionStoreState.loading &&
                    _collectionPageArguments.collection.photos.length == 0) {
                  return Center(
                    child: Loader(),
                  );
                }

                if (index ==
                    _collectionPageArguments.collection.photos.length) {
                  return Center(
                    child: Loader(),
                  );
                }

                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    PhotoPage.routeName,
                    arguments: PhotoPageArguments(
                        photo:
                            _collectionPageArguments.collection.photos[index],
                        heroTag:
                            'photo-${_collectionPageArguments.collection.photos[index].id}'),
                  ),
                  child: Hero(
                    tag:
                        'photo-${_collectionPageArguments.collection.photos[index].id}',
                    child: RoundedPhoto(
                      photo: _collectionPageArguments.collection.photos[index],
                      borderRadius: 7,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(_collectionPageArguments.collection.title),
    );
  }
}
