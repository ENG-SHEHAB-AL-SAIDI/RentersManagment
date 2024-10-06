import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_x;
import 'package:renters_management_front_end/app/models/result.dart';
import '../models/user_model.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

class UserServices {
  static User? _user;

  static Future<Result<bool>> userLogin(String email, String password) async {
    late Response response;
    try {
      response = await HttpProvider.post(EndPoints.login,
          data: {"email": email, "password": password});
      if(response.statusCode == 200){
        _user = User.fromJson(response.data["user"]);
        HttpProvider.addAuthTokenInterceptor(
            response.data["token"]["original"]["access_token"]);
        return Result(hasError: false, statusCode: response.statusCode,data: true);
      }
      return Result(hasError: false, statusCode: response.statusCode,data: false);
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            hasError: true,
            statusCode: error.response?.statusCode,
            message: error.response?.statusMessage);
      }
      return Result(hasError: true, message: error.message);
    }
  }

  static Future<void> userLogout() async {
    try {
      Response response = await HttpProvider.post(EndPoints.logOut);
      if (response.statusCode == 200) {
        get_x.Get.offAllNamed("/login");
      }
    } on DioException catch (error) {
      if (error.response != null) {
        if (kDebugMode) {
          print(error);
        }
      }
    }
  }

  static Future<Result<User>> fetchUser({bool hardFetch = false}) async {
    if (_user != null && !hardFetch) {
      return Result(data: _user, hasError: false, message: "successful");
    }

    late Response response;
    try {
      response = await HttpProvider.post(EndPoints.getUserData);
      _user = User.fromJson(response.data["user"]);
      return Result(
          data: _user,
          hasError: false,
          statusCode: response.statusCode,
          message: "successful");
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            hasError: true,
            statusCode: error.response?.statusCode,
            data: error.response?.data);
      }
      return Result(hasError: true, message: error.message);
    }
  }

  static void write() {}
}
