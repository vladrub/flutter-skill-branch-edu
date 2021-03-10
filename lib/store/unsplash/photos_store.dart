import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
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
    try {
      _photosFuture = ObservableFuture(
        unsplashStore.repository.fetchPhotos(
          perPage: perPage,
          page: 1,
        ),
      );

      var _photos = await _photosFuture;

      photos.addAll(_photos);
    } on Exception catch (_) {
      throw Exception('Ошибка загрузки фото!');
    } catch (e) {
      print(e);
      throw Exception('Ошибка загрузки фото!');
    }
  }
}
