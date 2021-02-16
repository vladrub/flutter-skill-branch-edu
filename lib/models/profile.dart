import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile extends _Profile with _$Profile {
  Profile({
    String username,
    String name,
    String bio,
    ProfileImage profileImage,
    String portfolioUrl,
    int followersCount,
    int followingCount,
    List<Photo> photos,
    List<Photo> likedPhotos,
  }) : super(username, name, bio, profileImage, portfolioUrl, followersCount,
            followingCount) {
    if (photos != null) this.photos = ObservableList.of(photos);
    if (likedPhotos != null) this.likedPhotos = ObservableList.of(likedPhotos);
  }

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

abstract class _Profile with Store {
  _Profile(this.username, this.name, this.bio, this.profileImage,
      this.portfolioUrl, this.followersCount, this.followingCount,
      {this.photos, this.likedPhotos});

  String username;
  String name;
  String bio;
  String location;

  @observable
  ObservableList<Photo> photos = ObservableList<Photo>.of([]);

  @observable
  ObservableList<Photo> likedPhotos = ObservableList<Photo>.of([]);

  @JsonKey(name: 'portfolio_url')
  String portfolioUrl;

  @JsonKey(name: 'profile_image')
  ProfileImage profileImage;

  @JsonKey(name: 'followers_count')
  int followersCount;

  @JsonKey(name: 'following_count')
  int followingCount;
}

@JsonSerializable(explicitToJson: true)
class ProfileImage {
  final String small;
  final String medium;
  final String large;

  ProfileImage({this.small, this.medium, this.large});

  factory ProfileImage.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileImageToJson(this);
}
