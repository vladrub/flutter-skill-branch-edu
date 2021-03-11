import 'package:FlutterGalleryApp/data/unsplash_repository.dart';
import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'photo.g.dart';

@JsonSerializable(explicitToJson: true)
class Photo extends _Photo with _$Photo {
  Photo({
    String id,
    String color,
    int likes,
    ImageUrl urls,
    bool likedByUser,
    String description,
    int width,
    int height,
    DateTime createdAt,
    Profile profile,
    UnsplashRepository unsplashRepository,
  }) : super(
          id,
          color,
          likes,
          urls,
          likedByUser,
          description,
          width,
          height,
          createdAt,
          profile,
          unsplashRepository,
        );

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

abstract class _Photo with Store {
  _Photo(
    this.id,
    this.color,
    this.likes,
    this.urls,
    this.likedByUser,
    this.description,
    this.width,
    this.height,
    this.createdAt,
    this.profile,
    this.unsplashRepository,
  );

  @JsonKey(ignore: true)
  UnsplashRepository unsplashRepository;

  String id;
  String color;

  @observable
  int likes;

  String description;
  int width;
  int height;

  @observable
  @JsonKey(name: 'liked_by_user')
  bool likedByUser;

  ImageUrl urls;

  @JsonKey(name: 'user')
  Profile profile;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @action
  Future<void> like() async {
    try {
      await unsplashRepository.likePhoto(id);
      likedByUser = true;
      likes++;
    } on Exception catch (_) {
      throw Exception('Ошибка лайка фото!');
    }
  }

  @action
  Future<void> unlike() async {
    try {
      await unsplashRepository.unlikePhoto(id);
      likedByUser = false;
      likes--;
    } on Exception catch (_) {
      throw Exception('Ошибка лайка фото!');
    }
  }
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
