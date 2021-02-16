import 'dart:convert';
import 'package:FlutterGalleryApp/models/auth.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class UnsplashRepository {
  static const String appId = "106854";
  // static const String accessKey =
  //     '5df87a6e1d420cd50124dd4e5a7ef195f18373222b401f98bca536309ddf2896';
  // static const String secretKey =
  //     'd89d77d0c47a9c2d699a1d57efcc6c708794b145b729ba92cba57ea5adaa31da';

  static const String accessKey = '8TVzZQqShIvNnurPqFPZLwvf6VRHYL-s5r-KWC57MBo';
  static const String secretKey = '6uN0FvsCIkPP6JHnqx6ZuPF2WbnG-YJq6DG1K0YA7M0';

  //authorize url from https://unsplash.com/oauth/applications/{your_app_id}
  static const String authUrl =
      'https://unsplash.com/oauth/authorize?client_id=$accessKey&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=public+write_likes';

  String authToken;

  Dio _dio;

  UnsplashRepository() {
    _dio = Dio();

    _dio.options.baseUrl = "https://api.unsplash.com/";
  }

  void setAuthToken(String token) {
    authToken = token;
    _dio.options.headers = {'Authorization': 'Bearer $token'};
  }

  static Future<Auth> doLogin({String oneTimeCode}) async {
    var response = await http.post('https://unsplash.com/oauth/token',
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            '{"client_id":"$accessKey","client_secret":"$secretKey","redirect_uri":"urn:ietf:wg:oauth:2.0:oob","code":"$oneTimeCode","grant_type":"authorization_code"}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Auth.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<Profile> fetchProfile(String userName) async {
    try {
      Response response = await _dio.get('users/$userName');
      return Profile.fromJson(response.data);
    } on DioError catch (e) {
      print('Error: ${e.error}');
      throw Exception('Error: ${e.error}');
    } catch (e) {
      print('Error: ${e.error}');
      throw Exception('Ошибка загрузки профиля!');
    }
  }

  Future<Profile> fetchMyProfile() async {
    if (authToken == '') Exception('Error: Not authorized!');
    try {
      Response response = await _dio.get('me');
      return Profile.fromJson(response.data);
    } on DioError catch (e) {
      print('Error: ${e.error}');
      throw Exception('Error: ${e.error}');
    } catch (e) {
      print('Error: ${e.error}');
      throw Exception('Ошибка загрузки профиля!');
    }
  }

  Future<List<Photo>> fetchProfilePhotos(String userName) async {
    try {
      Response response = await _dio.get('users/$userName/photos');
      List data = response.data;
      List<Photo> photos = [];
      data.forEach((photo) => photos.add(Photo.fromJson(photo)));
      return photos;
    } on DioError catch (e) {
      throw Exception('Error: ${e.error}');
    }
  }

  Future<List<Photo>> fetchProfileLikedPhotos(String userName,
      {int perPage = 15, int page = 1}) async {
    try {
      Response response = await _dio.get(
        'users/$userName/likes',
        queryParameters: {'per_page': perPage, 'page': page},
      );
      List data = response.data;
      List<Photo> photos = [];
      data.forEach((photo) => photos.add(Photo.fromJson(photo)));
      return photos;
    } on DioError catch (e) {
      throw Exception('Error: ${e.error}');
    }
  }

  // static Future<PhotoList> getPhotos(int page, int perPage) async {
  //   var response = await http.get(
  //       'https://api.unsplash.com/photos?page=$page&per_page=$perPage',
  //       headers: {'Authorization': 'Bearer $authToken'});

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return PhotoList.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }

  // static Future<Photo> getRandomPhoto() async {
  //   var response = await http.get('https://api.unsplash.com/photos/random',
  //       headers: {'Authorization': 'Bearer $authToken'});

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return Photo.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }

  // static Future<bool> likePhoto(String photoId) async {
  //   var response = await http
  //       .post('https://api.unsplash.com/photos/$photoId/like', headers: {
  //     'Authorization': 'Bearer $authToken',
  //   });

  //   print(response.body);
  //   print(response.reasonPhrase);

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return true; //returns 201 - Created
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }

  // static Future<bool> unlikePhoto(String photoId) async {
  //   var response = await http
  //       .delete('https://api.unsplash.com/photos/$photoId/like', headers: {
  //     'Authorization': 'Bearer $authToken',
  //   });

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return true; //returns 201 - Created
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }
}