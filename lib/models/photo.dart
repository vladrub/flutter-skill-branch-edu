import 'package:FlutterGalleryApp/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable(explicitToJson: true)
class Photo {
  String id;
  String color;
  int likes;
  String description;
  int width;
  int height;

  @JsonKey(name: 'liked_by_user')
  bool likedByUser;

  ImageUrl urls;

  @JsonKey(name: 'user')
  Profile profile;

  Photo({
    this.id,
    this.color,
    this.likes,
    this.urls,
    this.likedByUser,
    this.description,
    this.width,
    this.height,
    this.profile,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ImageUrl {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  ImageUrl({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) =>
      _$ImageUrlFromJson(json);
  Map<String, dynamic> toJson() => _$ImageUrlToJson(this);
}
