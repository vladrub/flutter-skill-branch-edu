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
    if (profile.photos != null) return ProfileStoreState.loaded;
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
    if (profile.likedPhotos != null) return ProfileStoreState.loaded;
    if (_profileLikedPhotosFuture == null ||
        _profileLikedPhotosFuture.status == FutureStatus.rejected) {
      return ProfileStoreState.initial;
    }
    return _profileLikedPhotosFuture.status == FutureStatus.pending
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
          profiles.add(await _profileFuture);
        } catch (e) {
          throw Exception('Ошибка загрузки профиля!');
        }
      }
    }
  }

  @action
  Future<void> fetchProfilePhotos() async {
    if (profile == null) throw Exception('Error: no profile!');

    print(profile);

    // if (profile.photos == null) {
    //   _profilePhotosFuture = ObservableFuture(
    //       unsplashStore.repository.fetchProfilePhotos(profile.username));
    //   profile.photos = await _profilePhotosFuture;

    //   profiles.forEach((profile) {
    //     if (profile.username == this.profile.username) {
    //       this.profile.photos = profile.photos;
    //     }
    //   });
    // }
  }

  @action
  Future<void> fetchProfileLikedPhotos({bool reload = false}) async {
    if (profile == null) throw Exception('Error: no profile!');

    if (profile.likedPhotos == null || reload) {
      try {
        _profileLikedPhotosFuture = ObservableFuture(
            unsplashStore.repository.fetchProfileLikedPhotos(profile.username));
        List<Photo> likedPhotos = await _profileLikedPhotosFuture;

        profiles.forEach((profile) {
          if (profile.username == this.userName) {
            profile.likedPhotos = ObservableList.of(likedPhotos);
          }
        });
      } on Exception catch (_) {
        throw Exception('Ошибка загрузки лайкнутых фото профиля!');
      } catch (e) {
        throw Exception('Ошибка загрузки лайкнутых фото профиля!');
      }
    }
  }
}
