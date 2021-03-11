// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection(
    id: json['id'] as String,
    title: json['title'] as String,
    coverPhoto: json['cover_photo'] == null
        ? null
        : Photo.fromJson(json['cover_photo'] as Map<String, dynamic>),
    profile: json['user'] == null
        ? null
        : Profile.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover_photo': instance.coverPhoto?.toJson(),
      'user': instance.profile?.toJson(),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Collection on _Collection, Store {
  Computed<CollectionStoreState> _$photosStateComputed;

  @override
  CollectionStoreState get photosState => (_$photosStateComputed ??=
          Computed<CollectionStoreState>(() => super.photosState,
              name: '_Collection.photosState'))
      .value;

  final _$_photosFutureAtom = Atom(name: '_Collection._photosFuture');

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

  final _$photosAtom = Atom(name: '_Collection.photos');

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

  final _$pageAtom = Atom(name: '_Collection.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$isLastPageAtom = Atom(name: '_Collection.isLastPage');

  @override
  bool get isLastPage {
    _$isLastPageAtom.reportRead();
    return super.isLastPage;
  }

  @override
  set isLastPage(bool value) {
    _$isLastPageAtom.reportWrite(value, super.isLastPage, () {
      super.isLastPage = value;
    });
  }

  final _$fetchPhotosAsyncAction = AsyncAction('_Collection.fetchPhotos');

  @override
  Future<void> fetchPhotos({bool reFresh = false, int perPage = 30}) {
    return _$fetchPhotosAsyncAction
        .run(() => super.fetchPhotos(reFresh: reFresh, perPage: perPage));
  }

  @override
  String toString() {
    return '''
photos: ${photos},
page: ${page},
isLastPage: ${isLastPage},
photosState: ${photosState}
    ''';
  }
}
