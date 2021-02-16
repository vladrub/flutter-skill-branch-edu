// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool> _$signedInComputed;

  @override
  bool get signedIn => (_$signedInComputed ??=
          Computed<bool>(() => super.signedIn, name: '_AuthStore.signedIn'))
      .value;

  final _$tokenAtom = Atom(name: '_AuthStore.token');

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$userNameAtom = Atom(name: '_AuthStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$getTokenAsyncAction = AsyncAction('_AuthStore.getToken');

  @override
  Future<void> getToken() {
    return _$getTokenAsyncAction.run(() => super.getToken());
  }

  final _$setTokenAsyncAction = AsyncAction('_AuthStore.setToken');

  @override
  Future<void> setToken(dynamic newToken) {
    return _$setTokenAsyncAction.run(() => super.setToken(newToken));
  }

  final _$signInAsyncAction = AsyncAction('_AuthStore.signIn');

  @override
  Future<void> signIn(String oneTimeCode) {
    return _$signInAsyncAction.run(() => super.signIn(oneTimeCode));
  }

  final _$signOutAsyncAction = AsyncAction('_AuthStore.signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void setUserName(String userName) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setUserName');
    try {
      return super.setUserName(userName);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token},
userName: ${userName},
signedIn: ${signedIn}
    ''';
  }
}