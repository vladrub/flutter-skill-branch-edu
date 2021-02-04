import 'package:FlutterGalleryApp/data/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final _secureStorage = new FlutterSecureStorage();

  @observable
  String token;

  @action
  Future<void> getToken() async =>
      token = await _secureStorage.read(key: 'token');

  @action
  Future<void> setToken(newToken) async {
    token = newToken;
    await _secureStorage.write(key: 'token', value: newToken);
  }

  @computed
  bool get signedIn => token != null ? true : false;

  @action
  Future<void> signIn(String oneTimeCode) async {
    Repository.doLogin(oneTimeCode: oneTimeCode).then((value) async {
      await setToken(value.accessToken);
    });
  }

  @action
  Future<void> signOut() async {
    token = null;
    await _secureStorage.delete(key: 'token');
  }
}
