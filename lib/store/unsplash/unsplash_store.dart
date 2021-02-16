import 'package:FlutterGalleryApp/data/unsplash_repository.dart';
import 'package:FlutterGalleryApp/store/unsplash/auth_store.dart';
import 'package:FlutterGalleryApp/store/unsplash/profile_store.dart';
import 'package:mobx/mobx.dart';

part 'unsplash_store.g.dart';

class UnsplashStore extends _UnsplashStore with _$UnsplashStore {
  UnsplashStore(UnsplashRepository unsplashRepository)
      : super(unsplashRepository);
}

abstract class _UnsplashStore with Store {
  UnsplashRepository repository;
  AuthStore authStore;
  ProfileStore profileStore;

  _UnsplashStore(this.repository) {
    authStore = AuthStore(unsplashStore: this);
    profileStore = ProfileStore(unsplashStore: this);
  }
}
