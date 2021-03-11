import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

enum SearchStoreState { initial, loading, loaded }

abstract class _SearchStore with Store {
  _SearchStore({this.unsplashStore});

  UnsplashStore unsplashStore;

  @observable
  ObservableFuture<List<Photo>> _searchFuture;

  @observable
  ObservableList<Photo> photos = ObservableList<Photo>.of([]);

  @observable
  int page = 1;

  @observable
  bool isLastPage = false;

  @observable
  String errorMessage;

  @computed
  SearchStoreState get state {
    if (_searchFuture == null ||
        _searchFuture.status == FutureStatus.rejected) {
      return SearchStoreState.initial;
    }
    return _searchFuture.status == FutureStatus.pending
        ? SearchStoreState.loading
        : SearchStoreState.loaded;
  }

  @action
  Future<void> search(String query,
      {bool reFresh = false, int perPage = 15}) async {
    if (reFresh) {
      photos = ObservableList<Photo>.of([]);
      page = 1;
      isLastPage = false;
    }

    try {
      print('Загрузка страницы № $page');

      _searchFuture = ObservableFuture(
        unsplashStore.repository.search(
          query,
          perPage: perPage,
          page: page,
        ),
      );

      var _photos = await _searchFuture;

      photos.addAll(_photos);
      print('Добавленно фоток ${_photos.length}');
      page++;

      if (photos.length < perPage) {
        print('Это последняя страница');
        isLastPage = true;
      }
    } on Exception catch (_) {
      throw Exception('Ошибка загрузки фото!');
    } catch (e) {
      print(e);
      throw Exception('Ошибка загрузки фото!');
    }
  }
}
