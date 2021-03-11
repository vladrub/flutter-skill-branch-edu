import 'package:FlutterGalleryApp/pages/photo/photo.dart';
import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/store/unsplash/search_store.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  UnsplashStore _unsplashStore;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if (_unsplashStore.searchStore.state != SearchStoreState.loading) {
          _unsplashStore.searchStore.search(_textEditingController.text);
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
    _unsplashStore = Provider.of<UnsplashStore>(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        title: TextField(
          autofocus: true,
          textInputAction: TextInputAction.search,
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: IconButton(
              icon: Icon(
                AppIcons.search,
                size: 13,
                color: AppColors.alto,
              ),
              onPressed: () {},
            ),
          ),
          onSubmitted: (String str) {
            _unsplashStore.searchStore.search(str, reFresh: true);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Observer(builder: (_) {
          if (_unsplashStore.searchStore.state == SearchStoreState.loading &&
              _unsplashStore.searchStore.photos.length == 0) {
            return Center(
              child: Loader(),
            );
          }

          if (_unsplashStore.searchStore.photos.length == 0) {
            return Center(
              child: Text('Nothing found.'),
            );
          }

          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              _unsplashStore.searchStore
                  .search(_textEditingController.text, reFresh: true);
            },
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 3,
              itemCount: _unsplashStore.searchStore.photos.length + 1,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (index == _unsplashStore.searchStore.photos.length) {
                  return Center(
                    child: Loader(),
                  );
                }

                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    PhotoPage.routeName,
                    arguments: PhotoPageArguments(
                        photo: _unsplashStore.searchStore.photos[index],
                        heroTag:
                            'photo-${_unsplashStore.searchStore.photos[index].id}'),
                  ),
                  child: RoundedPhoto(
                    photo: _unsplashStore.searchStore.photos[index],
                    borderRadius: 7,
                  ),
                );
              },
              staggeredTileBuilder: (int index) {
                if (index == _unsplashStore.searchStore.photos.length) {
                  return new StaggeredTile.count(3, 2);
                }
                return new StaggeredTile.count(
                    (index % 10 == 0) ? 2 : 1, (index % 10 == 0) ? 2 : 1);
              },
              mainAxisSpacing: 9.0,
              crossAxisSpacing: 9.0,
            ),
          );
        }),
      ),
    );
  }
}
