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
