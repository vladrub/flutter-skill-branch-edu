import 'package:FlutterGalleryApp/data/unsplash_repository.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final _secureStorage = new FlutterSecureStorage();

  _AuthStore({this.unsplashStore});

  UnsplashStore unsplashStore;

  @observable
  String token;

  @observable
  String userName;

  @action
  Future<void> getToken() async {
    token = await _secureStorage.read(key: 'token');
    unsplashStore.repository.setAuthToken(token);
  }

  @action
  Future<void> setToken(newToken) async {
    token = newToken;
    unsplashStore.repository.setAuthToken(newToken);
    await _secureStorage.write(key: 'token', value: newToken);
  }

  @computed
  bool get signedIn => token != null ? true : false;

  @action
  Future<void> signIn(String oneTimeCode) async {
    UnsplashRepository.doLogin(oneTimeCode: oneTimeCode).then((value) async {
      await setToken(value.accessToken);
    });
  }

  @action
  Future<void> signOut() async {
    token = null;
    await _secureStorage.delete(key: 'token');
  }

  @action
  void setUserName(String userName) => this.userName = userName;
}
