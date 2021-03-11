// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    id: json['id'] as String,
    username: json['username'] as String,
    name: json['name'] as String,
    bio: json['bio'] as String,
    profileImage: json['profile_image'] == null
        ? null
        : ProfileImage.fromJson(json['profile_image'] as Map<String, dynamic>),
    portfolioUrl: json['portfolio_url'] as String,
    followersCount: json['followers_count'] as int,
    followingCount: json['following_count'] as int,
    photos: (json['photos'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    photosPage: json['photosPage'] as int,
    photosIsLastPage: json['photosIsLastPage'] as bool,
    likedPhotos: (json['likedPhotos'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    likedPhotosPage: json['likedPhotosPage'] as int,
    likedPhotosIsLastPage: json['likedPhotosIsLastPage'] as bool,
    collections: (json['collections'] as List)
        ?.map((e) =>
            e == null ? null : Collection.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    collectionsPage: json['collectionsPage'] as int,
    collectionsIsLastPage: json['collectionsIsLastPage'] as bool,
  )..location = json['location'] as String;
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'bio': instance.bio,
      'location': instance.location,
      'photos': instance.photos?.map((e) => e?.toJson())?.toList(),
      'photosPage': instance.photosPage,
      'photosIsLastPage': instance.photosIsLastPage,
      'likedPhotos': instance.likedPhotos?.map((e) => e?.toJson())?.toList(),
      'likedPhotosPage': instance.likedPhotosPage,
      'likedPhotosIsLastPage': instance.likedPhotosIsLastPage,
      'collections': instance.collections?.map((e) => e?.toJson())?.toList(),
      'collectionsPage': instance.collectionsPage,
      'collectionsIsLastPage': instance.collectionsIsLastPage,
      'portfolio_url': instance.portfolioUrl,
      'profile_image': instance.profileImage?.toJson(),
      'followers_count': instance.followersCount,
      'following_count': instance.followingCount,
    };

ProfileImage _$ProfileImageFromJson(Map<String, dynamic> json) {
  return ProfileImage(
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$ProfileImageToJson(ProfileImage instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Profile on _Profile, Store {
  final _$photosAtom = Atom(name: '_Profile.photos');

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

  final _$photosPageAtom = Atom(name: '_Profile.photosPage');

  @override
  int get photosPage {
    _$photosPageAtom.reportRead();
    return super.photosPage;
  }

  @override
  set photosPage(int value) {
    _$photosPageAtom.reportWrite(value, super.photosPage, () {
      super.photosPage = value;
    });
  }

  final _$photosIsLastPageAtom = Atom(name: '_Profile.photosIsLastPage');

  @override
  bool get photosIsLastPage {
    _$photosIsLastPageAtom.reportRead();
    return super.photosIsLastPage;
  }

  @override
  set photosIsLastPage(bool value) {
    _$photosIsLastPageAtom.reportWrite(value, super.photosIsLastPage, () {
      super.photosIsLastPage = value;
    });
  }

  final _$likedPhotosAtom = Atom(name: '_Profile.likedPhotos');

  @override
  ObservableList<Photo> get likedPhotos {
    _$likedPhotosAtom.reportRead();
    return super.likedPhotos;
  }

  @override
  set likedPhotos(ObservableList<Photo> value) {
    _$likedPhotosAtom.reportWrite(value, super.likedPhotos, () {
      super.likedPhotos = value;
    });
  }

  final _$likedPhotosPageAtom = Atom(name: '_Profile.likedPhotosPage');

  @override
  int get likedPhotosPage {
    _$likedPhotosPageAtom.reportRead();
    return super.likedPhotosPage;
  }

  @override
  set likedPhotosPage(int value) {
    _$likedPhotosPageAtom.reportWrite(value, super.likedPhotosPage, () {
      super.likedPhotosPage = value;
    });
  }

  final _$likedPhotosIsLastPageAtom =
      Atom(name: '_Profile.likedPhotosIsLastPage');

  @override
  bool get likedPhotosIsLastPage {
    _$likedPhotosIsLastPageAtom.reportRead();
    return super.likedPhotosIsLastPage;
  }

  @override
  set likedPhotosIsLastPage(bool value) {
    _$likedPhotosIsLastPageAtom.reportWrite(value, super.likedPhotosIsLastPage,
        () {
      super.likedPhotosIsLastPage = value;
    });
  }

  final _$collectionsAtom = Atom(name: '_Profile.collections');

  @override
  ObservableList<Collection> get collections {
    _$collectionsAtom.reportRead();
    return super.collections;
  }

  @override
  set collections(ObservableList<Collection> value) {
    _$collectionsAtom.reportWrite(value, super.collections, () {
      super.collections = value;
    });
  }

  final _$collectionsPageAtom = Atom(name: '_Profile.collectionsPage');

  @override
  int get collectionsPage {
    _$collectionsPageAtom.reportRead();
    return super.collectionsPage;
  }

  @override
  set collectionsPage(int value) {
    _$collectionsPageAtom.reportWrite(value, super.collectionsPage, () {
      super.collectionsPage = value;
    });
  }

  final _$collectionsIsLastPageAtom =
      Atom(name: '_Profile.collectionsIsLastPage');

  @override
  bool get collectionsIsLastPage {
    _$collectionsIsLastPageAtom.reportRead();
    return super.collectionsIsLastPage;
  }

  @override
  set collectionsIsLastPage(bool value) {
    _$collectionsIsLastPageAtom.reportWrite(value, super.collectionsIsLastPage,
        () {
      super.collectionsIsLastPage = value;
    });
  }

  final _$_profilePhotosFutureAtom =
      Atom(name: '_Profile._profilePhotosFuture');

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
      Atom(name: '_Profile._profileLikedPhotosFuture');

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
      Atom(name: '_Profile._profileCollectionsFuture');

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

  @override
  String toString() {
    return '''
photos: ${photos},
photosPage: ${photosPage},
photosIsLastPage: ${photosIsLastPage},
likedPhotos: ${likedPhotos},
likedPhotosPage: ${likedPhotosPage},
likedPhotosIsLastPage: ${likedPhotosIsLastPage},
collections: ${collections},
collectionsPage: ${collectionsPage},
collectionsIsLastPage: ${collectionsIsLastPage}
    ''';
  }
}
