// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PhotosStore on _PhotosStore, Store {
  Computed<PhotosStoreState> _$stateComputed;

  @override
  PhotosStoreState get state =>
      (_$stateComputed ??= Computed<PhotosStoreState>(() => super.state,
              name: '_PhotosStore.state'))
          .value;

  final _$_photosFutureAtom = Atom(name: '_PhotosStore._photosFuture');

  @override
  ObservableFuture<List<Photo>> get _photosFuture {
    _$_photosFutureAtom.reportRead();
    return super._photosFuture;
  }

  @override
  set _photosFuture(ObservableFuture<List<Photo>> value) {
    _$_photosFutureAtom.reportWrite(value, super._photosFuture, () {
      super._photosFuture = value;
    });
  }

  final _$photosAtom = Atom(name: '_PhotosStore.photos');

  @override
  ObservableList<Photo> get photos {
    _$photosAtom.reportRead();
    return super.photos;
  }

  @override
  set photos(ObservableList<Photo> value) {
    _$photosAtom.reportWrite(value, super.photos, () {
      super.photos = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_PhotosStore.errorMessage');

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

  final _$fetchPhotosAsyncAction = AsyncAction('_PhotosStore.fetchPhotos');

  @override
  Future<void> fetchPhotos({bool reFresh = false, int perPage = 15}) {
    return _$fetchPhotosAsyncAction
        .run(() => super.fetchPhotos(reFresh: reFresh, perPage: perPage));
  }

  @override
  String toString() {
    return '''
photos: ${photos},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
