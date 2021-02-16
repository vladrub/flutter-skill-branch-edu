// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
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
    likedPhotos: (json['likedPhotos'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..location = json['location'] as String;
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'bio': instance.bio,
      'location': instance.location,
      'photos': instance.photos?.map((e) => e?.toJson())?.toList(),
      'likedPhotos': instance.likedPhotos?.map((e) => e?.toJson())?.toList(),
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

  @override
  String toString() {
    return '''
photos: ${photos},
likedPhotos: ${likedPhotos}
    ''';
  }
}
