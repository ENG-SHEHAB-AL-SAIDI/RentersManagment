import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:renters_management_front_end/app/models/result.dart';

import '../models/user_model.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

class UserServices {
  static User? _user;

  static Future<Result> userLogin(String email, String password) async {
    late Response response;
    try {
      response = await HttpProvider.post(EndPoints.login,
          data: {"email": email, "password": password});
      _user = User.fromJson(response.data["user"]);
      HttpProvider.addAuthTokenInterceptor(
          response.data["token"]["original"]["access_token"]);
    } catch (error) {
      if (kDebugMode) {
        return Result(hasError: true, statusCode: response.statusCode);
      }
    }
    return Result(hasError: false, statusCode: response.statusCode);
  }

  static Future<Result<User>> fetchUser({bool hardFetch = false}) async {

    if (_user != null && !hardFetch) {
      return Result(data: _user, hasError: false, message: "successful");
    }

    late Response response;
    try {
      response = await HttpProvider.post(EndPoints.getUserData);
      _user = User.fromJson(response.data["user"]);
    } catch (error) {
      return Result(
          hasError: true,
          statusCode: response.statusCode,
          message: response.data);
    }
    return Result(
        data: _user,
        hasError: false,
        statusCode: response.statusCode,
        message: "successful");
  }

  static void write() {}
}
