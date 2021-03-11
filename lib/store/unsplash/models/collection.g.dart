// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection(
    id: json['id'] as String,
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
      'cover_photo': instance.coverPhoto?.toJson(),
      'user': instance.profile?.toJson(),
    };
