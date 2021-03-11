import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile extends _Profile with _$Profile {
  Profile({
    String id,
    String username,
    String name,
    String bio,
    ProfileImage profileImage,
    String portfolioUrl,
    int followersCount,
    int followingCount,
    List<Photo> photos,
    int photosPage,
    bool photosIsLastPage,
    List<Photo> likedPhotos,
    int likedPhotosPage,
    bool likedPhotosIsLastPage,
    List<Collection> collections,
    int collectionsPage,
    bool collectionsIsLastPage,
  }) : super(
          id,
          username,
          name,
          bio,
          profileImage,
          portfolioUrl,
          followersCount,
          followingCount,
          photosPage = 1,
          photosIsLastPage = false,
          likedPhotosPage = 1,
          likedPhotosIsLastPage = false,
          collectionsPage = 1,
          collectionsIsLastPage = false,
        ) {
    if (photos != null) this.photos = ObservableList.of(photos);
    if (likedPhotos != null) this.likedPhotos = ObservableList.of(likedPhotos);
    if (collections != null) this.collections = ObservableList.of(collections);
  }

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

abstract class _Profile with Store {
  _Profile(
    this.id,
    this.username,
    this.name,
    this.bio,
    this.profileImage,
    this.portfolioUrl,
    this.followersCount,
    this.followingCount,
    this.photosPage,
    this.photosIsLastPage,
    this.likedPhotosPage,
    this.likedPhotosIsLastPage,
    this.collectionsPage,
    this.collectionsIsLastPage, {
    this.photos,
    this.likedPhotos,
  });

  String id;
  String username;
  String name;
  String bio;
  String location;

  @observable
  ObservableList<Photo> photos = ObservableList<Photo>.of([]);

  @observable
  int photosPage = 1;

  @observable
  bool photosIsLastPage = false;

  @observable
  ObservableList<Photo> likedPhotos = ObservableList<Photo>.of([]);

  @observable
  int likedPhotosPage = 1;

  @observable
  bool likedPhotosIsLastPage = false;

  @observable
  ObservableList<Collection> collections = ObservableList<Collection>.of([]);

  @observable
  int collectionsPage = 1;

  @observable
  bool collectionsIsLastPage = false;

  @JsonKey(name: 'portfolio_url')
  String portfolioUrl;

  @JsonKey(name: 'profile_image')
  ProfileImage profileImage;

  @JsonKey(name: 'followers_count')
  int followersCount;

  @JsonKey(name: 'following_count')
  int followingCount;

  @observable
  ObservableFuture<List<Photo>> _profilePhotosFuture;

  @observable
  ObservableFuture<List<Photo>> _profileLikedPhotosFuture;

  @observable
  ObservableFuture<List<Collection>> _profileCollectionsFuture;
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
