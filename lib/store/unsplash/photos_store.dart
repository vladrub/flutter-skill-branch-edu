import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:mobx/mobx.dart';

part 'photos_store.g.dart';

class PhotosStore = _PhotosStore with _$PhotosStore;

enum PhotosStoreState { initial, loading, loaded }

abstract class _PhotosStore with Store {
  _PhotosStore({this.unsplashStore});

  UnsplashStore unsplashStore;

  @observable
  ObservableFuture<List<Photo>> _photosFuture;

  @observable
  ObservableList<Photo> photos = ObservableList<Photo>.of([]);

  @observable
  int page = 1;

  @observable
  bool isLastPage = false;

  @observable
  String errorMessage;

  @computed
  PhotosStoreState get state {
    if (_photosFuture == null ||
        _photosFuture.status == FutureStatus.rejected) {
      return PhotosStoreState.initial;
    }
    return _photosFuture.status == FutureStatus.pending
        ? PhotosStoreState.loading
        : PhotosStoreState.loaded;
  }

  @action
  Future<void> fetchPhotos({bool reFresh = false, int perPage = 15}) async {
    if (reFresh) {
      photos = ObservableList<Photo>.of([]);
      page = 1;
      isLastPage = false;
    }

    try {
      print('Загрузка страницы № $page');

      _photosFuture = ObservableFuture(
        unsplashStore.repository.fetchPhotos(
          perPage: perPage,
          page: page,
        ),
      );

      var _photos = await _photosFuture;

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
