import 'dart:convert';
import 'package:FlutterGalleryApp/data/unsplash_constants.dart';
import 'package:FlutterGalleryApp/models/auth.dart';
import 'package:http/http.dart' as http;

class Repository {
  static String authToken = "";

  static Future<Auth> doLogin({String oneTimeCode}) async {
    var _accessKey = UnsplashConstants.accessKey;
    var _secretKey = UnsplashConstants.secretKey;

    var response = await http.post('https://unsplash.com/oauth/token',
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            '{"client_id":"$_accessKey","client_secret":"$_secretKey","redirect_uri":"urn:ietf:wg:oauth:2.0:oob","code":"$oneTimeCode","grant_type":"authorization_code"}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Auth.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
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
