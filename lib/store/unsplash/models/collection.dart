import 'package:FlutterGalleryApp/data/unsplash_repository.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'collection.g.dart';

enum CollectionStoreState { initial, loading, loaded }

@JsonSerializable(explicitToJson: true)
class Collection extends _Collection with _$Collection {
  Collection({
    String id,
    String title,
    Photo coverPhoto,
    Profile profile,
    UnsplashRepository unsplashRepository,
  }) : super(
          id,
          title,
          coverPhoto,
          profile,
          unsplashRepository,
        );

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}

abstract class _Collection with Store {
  _Collection(
    this.id,
    this.title,
    this.coverPhoto,
    this.profile,
    this.unsplashRepository,
  );

  @JsonKey(ignore: true)
  UnsplashRepository unsplashRepository;

  String id;

  String title;

  @JsonKey(name: 'cover_photo')
  Photo coverPhoto;

  @JsonKey(name: 'user')
  Profile profile;

  @observable
  ObservableFuture<List<Photo>> _photosFuture;

  @JsonKey(ignore: true)
  @observable
  ObservableList<Photo> photos = ObservableList<Photo>.of([]);

  @JsonKey(ignore: true)
  @observable
  int page = 1;

  @JsonKey(ignore: true)
  @observable
  bool isLastPage = false;

  @computed
  CollectionStoreState get photosState {
    if (_photosFuture == null ||
        _photosFuture.status == FutureStatus.rejected) {
      return CollectionStoreState.initial;
    }
    return _photosFuture.status == FutureStatus.pending
        ? CollectionStoreState.loading
        : CollectionStoreState.loaded;
  }

  @action
  Future<void> fetchPhotos({bool reFresh = false, int perPage = 30}) async {
    if (reFresh) {
      photos = ObservableList<Photo>.of([]);
      page = 1;
      isLastPage = false;
    }

    try {
      print('Загрузка страницы № $page');

      _photosFuture = ObservableFuture(
        unsplashRepository.fetchCollectionPhotos(
          id,
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
