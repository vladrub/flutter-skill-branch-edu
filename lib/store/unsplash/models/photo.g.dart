// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    id: json['id'] as String,
    color: json['color'] as String,
    likes: json['likes'] as int,
    urls: json['urls'] == null
        ? null
        : ImageUrl.fromJson(json['urls'] as Map<String, dynamic>),
    likedByUser: json['liked_by_user'] as bool,
    description: json['description'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    profile: json['user'] == null
        ? null
        : Profile.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'likes': instance.likes,
      'description': instance.description,
      'width': instance.width,
      'height': instance.height,
      'liked_by_user': instance.likedByUser,
      'urls': instance.urls?.toJson(),
      'user': instance.profile?.toJson(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

ImageUrl _$ImageUrlFromJson(Map<String, dynamic> json) {
  return ImageUrl(
    raw: json['raw'] as String,
    full: json['full'] as String,
    regular: json['regular'] as String,
    small: json['small'] as String,
    thumb: json['thumb'] as String,
  );
}

Map<String, dynamic> _$ImageUrlToJson(ImageUrl instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Photo on _Photo, Store {
  Computed<PhotosStoreState> _$relatedPhotosStateComputed;

  @override
  PhotosStoreState get relatedPhotosState => (_$relatedPhotosStateComputed ??=
          Computed<PhotosStoreState>(() => super.relatedPhotosState,
              name: '_Photo.relatedPhotosState'))
      .value;

  final _$likesAtom = Atom(name: '_Photo.likes');

  @override
  int get likes {
    _$likesAtom.reportRead();
    return super.likes;
  }

  @override
  set likes(int value) {
    _$likesAtom.reportWrite(value, super.likes, () {
      super.likes = value;
    });
  }

  final _$likedByUserAtom = Atom(name: '_Photo.likedByUser');

  @override
  bool get likedByUser {
    _$likedByUserAtom.reportRead();
    return super.likedByUser;
  }

  @override
  set likedByUser(bool value) {
    _$likedByUserAtom.reportWrite(value, super.likedByUser, () {
      super.likedByUser = value;
    });
  }

  final _$_relatedPhotosFutureAtom = Atom(name: '_Photo._relatedPhotosFuture');

  @override
  ObservableFuture<List<Photo>> get _relatedPhotosFuture {
    _$_relatedPhotosFutureAtom.reportRead();
    return super._relatedPhotosFuture;
  }

  @override
  set _relatedPhotosFuture(ObservableFuture<List<Photo>> value) {
    _$_relatedPhotosFutureAtom.reportWrite(value, super._relatedPhotosFuture,
        () {
      super._relatedPhotosFuture = value;
    });
  }

  final _$relatedPhotosAtom = Atom(name: '_Photo.relatedPhotos');

  @override
  ObservableList<Photo> get relatedPhotos {
    _$relatedPhotosAtom.reportRead();
    return super.relatedPhotos;
  }

  @override
  set relatedPhotos(ObservableList<Photo> value) {
    _$relatedPhotosAtom.reportWrite(value, super.relatedPhotos, () {
      super.relatedPhotos = value;
    });
  }

  final _$likeAsyncAction = AsyncAction('_Photo.like');

  @override
  Future<void> like() {
    return _$likeAsyncAction.run(() => super.like());
  }

  final _$unlikeAsyncAction = AsyncAction('_Photo.unlike');

  @override
  Future<void> unlike() {
    return _$unlikeAsyncAction.run(() => super.unlike());
  }

  final _$fetchRelatedPhotosAsyncAction =
      AsyncAction('_Photo.fetchRelatedPhotos');

  @override
  Future<void> fetchRelatedPhotos() {
    return _$fetchRelatedPhotosAsyncAction
        .run(() => super.fetchRelatedPhotos());
  }

  @override
  String toString() {
    return '''
likes: ${likes},
likedByUser: ${likedByUser},
relatedPhotos: ${relatedPhotos},
relatedPhotosState: ${relatedPhotosState}
    ''';
  }
}
