// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  Computed<Profile> _$profileComputed;

  @override
  Profile get profile => (_$profileComputed ??=
          Computed<Profile>(() => super.profile, name: '_ProfileStore.profile'))
      .value;
  Computed<ProfileStoreState> _$stateComputed;

  @override
  ProfileStoreState get state =>
      (_$stateComputed ??= Computed<ProfileStoreState>(() => super.state,
              name: '_ProfileStore.state'))
          .value;
  Computed<ProfileStoreState> _$photosStateComputed;

  @override
  ProfileStoreState get photosState => (_$photosStateComputed ??=
          Computed<ProfileStoreState>(() => super.photosState,
              name: '_ProfileStore.photosState'))
      .value;
  Computed<ProfileStoreState> _$likedPhotosStateComputed;

  @override
  ProfileStoreState get likedPhotosState => (_$likedPhotosStateComputed ??=
          Computed<ProfileStoreState>(() => super.likedPhotosState,
              name: '_ProfileStore.likedPhotosState'))
      .value;
  Computed<ProfileStoreState> _$collectionsStateComputed;

  @override
  ProfileStoreState get collectionsState => (_$collectionsStateComputed ??=
          Computed<ProfileStoreState>(() => super.collectionsState,
              name: '_ProfileStore.collectionsState'))
      .value;

  final _$_profileFutureAtom = Atom(name: '_ProfileStore._profileFuture');

  @override
  ObservableFuture<Profile> get _profileFuture {
    _$_profileFutureAtom.reportRead();
    return super._profileFuture;
  }

  @override
  set _profileFuture(ObservableFuture<Profile> value) {
    _$_profileFutureAtom.reportWrite(value, super._profileFuture, () {
      super._profileFuture = value;
    });
  }

  final _$_profilePhotosFutureAtom =
      Atom(name: '_ProfileStore._profilePhotosFuture');

  @override
  ObservableFuture<List<Photo>> get _profilePhotosFuture {
    _$_profilePhotosFutureAtom.reportRead();
    return super._profilePhotosFuture;
  }

  @override
  set _profilePhotosFuture(ObservableFuture<List<Photo>> value) {
    _$_profilePhotosFutureAtom.reportWrite(value, super._profilePhotosFuture,
        () {
      super._profilePhotosFuture = value;
    });
  }

  final _$_profileLikedPhotosFutureAtom =
      Atom(name: '_ProfileStore._profileLikedPhotosFuture');

  @override
  ObservableFuture<List<Photo>> get _profileLikedPhotosFuture {
    _$_profileLikedPhotosFutureAtom.reportRead();
    return super._profileLikedPhotosFuture;
  }

  @override
  set _profileLikedPhotosFuture(ObservableFuture<List<Photo>> value) {
    _$_profileLikedPhotosFutureAtom
        .reportWrite(value, super._profileLikedPhotosFuture, () {
      super._profileLikedPhotosFuture = value;
    });
  }

  final _$_profileCollectionsFutureAtom =
      Atom(name: '_ProfileStore._profileCollectionsFuture');

  @override
  ObservableFuture<List<Collection>> get _profileCollectionsFuture {
    _$_profileCollectionsFutureAtom.reportRead();
    return super._profileCollectionsFuture;
  }

  @override
  set _profileCollectionsFuture(ObservableFuture<List<Collection>> value) {
    _$_profileCollectionsFutureAtom
        .reportWrite(value, super._profileCollectionsFuture, () {
      super._profileCollectionsFuture = value;
    });
  }

  final _$profilesAtom = Atom(name: '_ProfileStore.profiles');

  @override
  ObservableList<Profile> get profiles {
    _$profilesAtom.reportRead();
    return super.profiles;
  }

  @override
  set profiles(ObservableList<Profile> value) {
    _$profilesAtom.reportWrite(value, super.profiles, () {
      super.profiles = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_ProfileStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$userNameAtom = Atom(name: '_ProfileStore.userName');

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

  final _$fetchProfileAsyncAction = AsyncAction('_ProfileStore.fetchProfile');

  @override
  Future<void> fetchProfile({String userName}) {
    return _$fetchProfileAsyncAction
        .run(() => super.fetchProfile(userName: userName));
  }

  final _$fetchProfilePhotosAsyncAction =
      AsyncAction('_ProfileStore.fetchProfilePhotos');

  @override
  Future<void> fetchProfilePhotos({bool reFresh = false, int perPage = 9}) {
    return _$fetchProfilePhotosAsyncAction.run(
        () => super.fetchProfilePhotos(reFresh: reFresh, perPage: perPage));
  }

  final _$fetchProfileLikedPhotosAsyncAction =
      AsyncAction('_ProfileStore.fetchProfileLikedPhotos');

  @override
  Future<void> fetchProfileLikedPhotos(
      {bool reFresh = false, int perPage = 9}) {
    return _$fetchProfileLikedPhotosAsyncAction.run(() =>
        super.fetchProfileLikedPhotos(reFresh: reFresh, perPage: perPage));
  }

  final _$fetchProfileCollectionsAsyncAction =
      AsyncAction('_ProfileStore.fetchProfileCollections');

  @override
  Future<void> fetchProfileCollections(
      {bool reFresh = false, int perPage = 9}) {
    return _$fetchProfileCollectionsAsyncAction.run(() =>
        super.fetchProfileCollections(reFresh: reFresh, perPage: perPage));
  }

  @override
  String toString() {
    return '''
profiles: ${profiles},
errorMessage: ${errorMessage},
userName: ${userName},
profile: ${profile},
state: ${state},
photosState: ${photosState},
likedPhotosState: ${likedPhotosState},
collectionsState: ${collectionsState}
    ''';
  }
}
