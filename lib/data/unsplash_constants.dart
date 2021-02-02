class UnsplashConstants {
  UnsplashConstants._();

  static const String appId = "106854";
  static const String accessKey =
      '5df87a6e1d420cd50124dd4e5a7ef195f18373222b401f98bca536309ddf2896';
  static const String secretKey =
      'd89d77d0c47a9c2d699a1d57efcc6c708794b145b729ba92cba57ea5adaa31da';

  //authorize url from https://unsplash.com/oauth/applications/{your_app_id}
  static const String authUrl =
      'https://unsplash.com/oauth/authorize?client_id=$accessKey&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=public+write_likes';
}
