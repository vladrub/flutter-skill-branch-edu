import 'package:FlutterGalleryApp/models/collection.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/models/profile.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

enum ProfileStoreState { initial, loading, loaded }

abstract class _ProfileStore with Store {
  _ProfileStore({this.unsplashStore});

  UnsplashStore unsplashStore;

  @observable
  ObservableFuture<Profile> _profileFuture;

  @observable
  ObservableFuture<List<Photo>> _profilePhotosFuture;

  @observable
  ObservableFuture<List<Photo>> _profileLikedPhotosFuture;

  @observable
  ObservableFuture<List<Collection>> _profileCollectionsFuture;

  @observable
  ObservableList<Profile> profiles = ObservableList<Profile>.of([]);

  @observable
  String errorMessage;

  @observable
  String userName;

  @computed
  Profile get profile =>
      profiles.firstWhere((profile) => profile.username == userName,
          orElse: () => null);

  @computed
  ProfileStoreState get state {
    if (profile != null) return ProfileStoreState.loaded;
    if (_profileFuture == null ||
        _profileFuture.status == FutureStatus.rejected) {
      return ProfileStoreState.initial;
    }
    return _profileFuture.status == FutureStatus.pending
        ? ProfileStoreState.loading
        : ProfileStoreState.loaded;
  }

  @computed
  ProfileStoreState get photosState {
    if (profile == null) return ProfileStoreState.loading;
    if (_profilePhotosFuture == null ||
        _profilePhotosFuture.status == FutureStatus.rejected) {
      return ProfileStoreState.initial;
    }
    return _profilePhotosFuture.status == FutureStatus.pending
        ? ProfileStoreState.loading
        : ProfileStoreState.loaded;
  }

  @computed
  ProfileStoreState get likedPhotosState {
    if (profile == null) return ProfileStoreState.loading;
    if (_profileLikedPhotosFuture == null ||
        _profileLikedPhotosFuture.status == FutureStatus.rejected) {
      return ProfileStoreState.initial;
    }
    return _profileLikedPhotosFuture.status == FutureStatus.pending
        ? ProfileStoreState.loading
        : ProfileStoreState.loaded;
  }

  @computed
  ProfileStoreState get collectionsState {
    if (profile == null) return ProfileStoreState.loading;
    if (_profileCollectionsFuture == null ||
        _profileCollectionsFuture.status == FutureStatus.rejected) {
      return ProfileStoreState.initial;
    }
    return _profileCollectionsFuture.status == FutureStatus.pending
        ? ProfileStoreState.loading
        : ProfileStoreState.loaded;
  }

  @action
  Future<void> fetchProfile({String userName}) async {
    this.userName = userName;

    if (profile == null) {
      if (userName == null) {
        if (unsplashStore.authStore.userName == null) {
          try {
            _profileFuture =
                ObservableFuture(unsplashStore.repository.fetchMyProfile());
            Profile _profile = await _profileFuture;
            _profile.photos.forEach((photo) => photo.profile = _profile);
            profiles.add(_profile);
            this.userName = _profile.username;
            unsplashStore.authStore.setUserName(profile.username);
          } catch (e) {
            throw Exception('Ошибка загрузки профиля!');
          }
        } else {
          this.userName = unsplashStore.authStore.userName;
        }
      } else {
        try {
          _profileFuture =
              ObservableFuture(unsplashStore.repository.fetchProfile(userName));
          Profile _profile = await _profileFuture;
          _profile.photos.forEach((photo) => photo.profile = _profile);
          profiles.add(_profile);
        } catch (e) {
          throw Exception('Ошибка загрузки профиля!');
        }
      }
    }
  }

  @action
  Future<void> fetchProfilePhotos(
      {bool reFresh = false, int perPage = 9}) async {
    if (profile == null) throw Exception('Error: no profile!');

    Profile _profile = profiles.firstWhere(
        (profile) => profile.username == this.userName,
        orElse: () => null);

    if (reFresh) {
      _profile.photos = null;
      _profile.photosPage = 1;
      _profile.photosIsLastPage = false;
    }

    print('Загрузка страницы № ${profile.photosPage}');

    try {
      _profilePhotosFuture = ObservableFuture(
        unsplashStore.repository.fetchProfilePhotos(
          profile.username,
          page: profile.photosPage,
          perPage: perPage,
        ),
      );
      List<Photo> photos = await _profilePhotosFuture;

      print('Получено новых ${photos.length} фоток');

      if (_profile.photos == null) {
        _profile.photos = ObservableList.of(photos);
      } else {
        _profile.photos.addAll(photos);
      }
      print('Добавленно фоток ${photos.length}');
      _profile.photosPage++;

      if (photos.length < perPage) {
        print('Это последняя страница');
        _profile.photosIsLastPage = true;
      }
    } on Exception catch (_) {
      throw Exception('Ошибка загрузки фото профиля!');
    } catch (e) {
      throw Exception('Ошибка загрузки фото профиля!');
    }
  }

  @action
  Future<void> fetchProfileLikedPhotos(
      {bool reFresh = false, int perPage = 9}) async {
    if (profile == null) throw Exception('Error: no profile!');

    Profile _profile = profiles.firstWhere(
        (profile) => profile.username == this.userName,
        orElse: () => null);

    if (reFresh) {
      _profile.likedPhotos = null;
      _profile.likedPhotosPage = 1;
      _profile.likedPhotosIsLastPage = false;
    }

    print('Загрузка страницы № ${profile.likedPhotosPage}');

    try {
      _profileLikedPhotosFuture = ObservableFuture(
        unsplashStore.repository.fetchProfileLikedPhotos(
          profile.username,
          page: profile.likedPhotosPage,
          perPage: perPage,
        ),
      );
      List<Photo> likedPhotos = await _profileLikedPhotosFuture;

      print('Получено новых ${likedPhotos.length} фоток');

      if (_profile.likedPhotos == null) {
        _profile.likedPhotos = ObservableList.of(likedPhotos);
      } else {
        _profile.likedPhotos.addAll(likedPhotos);
      }
      print('Добавленно фоток ${likedPhotos.length}');
      _profile.likedPhotosPage++;

      if (likedPhotos.length < perPage) {
        print('Это последняя страница');
        _profile.likedPhotosIsLastPage = true;
      }
    } on Exception catch (_) {
      throw Exception('Ошибка загрузки лайкнутых фото профиля!');
    } catch (e) {
      throw Exception('Ошибка загрузки лайкнутых фото профиля!');
    }
  }

  @action
  Future<void> fetchProfileCollections(
      {bool reFresh = false, int perPage = 9}) async {
    if (profile == null) throw Exception('Error: no profile!');

    Profile _profile = profiles.firstWhere(
        (profile) => profile.username == this.userName,
        orElse: () => null);

    if (reFresh) {
      _profile.collections = null;
      _profile.collectionsPage = 1;
      _profile.collectionsIsLastPage = false;
    }

    print('Загрузка страницы № ${profile.collectionsPage}');

    try {
      _profileCollectionsFuture = ObservableFuture(
        unsplashStore.repository.fetchProfileCollections(
          profile.username,
          page: profile.collectionsPage,
          perPage: perPage,
        ),
      );
      List<Collection> collections = await _profileCollectionsFuture;

      print('Получено новых ${collections.length} фоток');

      if (_profile.collections == null) {
        _profile.collections = ObservableList.of(collections);
      } else {
        _profile.collections.addAll(collections);
      }
      print('Добавленно фоток ${collections.length}');
      _profile.collectionsPage++;

      if (collections.length < perPage) {
        print('Это последняя страница');
        _profile.collectionsIsLastPage = true;
      }
    } on Exception catch (_) {
      throw Exception('Ошибка загрузки лайкнутых фото профиля!');
    } catch (e) {
      throw Exception('Ошибка загрузки лайкнутых фото профиля!');
    }
  }
}
