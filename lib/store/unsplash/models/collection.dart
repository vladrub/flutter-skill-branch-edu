import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection {
  String id;

  @JsonKey(name: 'cover_photo')
  Photo coverPhoto;

  @JsonKey(name: 'user')
  Profile profile;

  Collection({
    this.id,
    this.coverPhoto,
    this.profile,
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
