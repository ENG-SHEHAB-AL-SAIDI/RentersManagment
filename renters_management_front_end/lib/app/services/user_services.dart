import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

class UserServices {
  static User? _user;

  static Future<bool> userLogin(String email, String password) async {
    bool responseStat = false;
    late Response response;
    try {
      response = await HttpProvider.post(EndPoints.login,
          data: {"email": email, "password": password});
      _user = User.fromJson(response.data["user"]);
      HttpProvider.addAuthTokenInterceptor(
          response.data["token"]["original"]["access_token"]);
      responseStat = true;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return responseStat;
  }

  static Future<User> fetchUser({bool hardFetch = false}) async {
    if (_user != null && !hardFetch) {
      return _user!;
    }

    late Response response;
    try {
      response = await HttpProvider.post(EndPoints.getUserData);
      _user = User.fromJson(response.data);
    } catch (error) {
      throw Exception(error);
    }
    return _user!;
  }

  static void write() {}
}
