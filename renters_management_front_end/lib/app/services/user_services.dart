import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_x;
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import 'http_provider/http_provider.dart';

class UserServices {
  static SharedPreferences? _prefs;
  static User? _user;

  static Future<Result<bool>> userLogin(String email, String password,
      {bool rememberMe = false}) async {
    late Response? response;
    try {
      response = await HttpProvider.post("auth/login",
          data: {"email": email, "password": password});
      if (response?.statusCode == 200) {
        _user = User.fromJson(response?.data["user"]);
        HttpProvider.addAuthTokenInterceptor(
            response?.data["token"]["original"]["access_token"]);
        if (rememberMe) {
          _prefs ??= await SharedPreferences.getInstance();
          await _prefs?.setStringList(
              "credentials", <String>[email, password]);
        }

        return Result(
            hasError: false, statusCode: response?.statusCode, data: true);
      }
    } catch (error) {
      return Result(hasError: true, statusCode: 601, message: error.toString());
    }

    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 601,
        message: "error",
        data: false);
  }

  static Future<Result<bool>> userRegister(String name, String email,
      String password, String passwordConfirmation) async {
    late Response? response;
    try {
      response = await HttpProvider.post("auth/register", data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation
      });
      if (response?.statusCode == 200) {
        _user = User.fromJson(response?.data["user"]);
        HttpProvider.addAuthTokenInterceptor(
            response?.data["token"]["original"]["access_token"]);
        return Result(
            hasError: false, statusCode: response?.statusCode, data: true);
      }
    } catch (error) {
      return Result(hasError: true, statusCode: 601, message: error.toString());
    }

    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 601,
        message: "error",
        data: false);
  }

  static Future<Result?> userLogout() async {
    Response? response;
    try {
      response = await HttpProvider.post("auth/logout");
      if (response?.statusCode == 200) {
        _prefs ??= await SharedPreferences.getInstance();
        await _prefs?.remove("credentials");
        get_x.Get.offAllNamed("/login");
        return null;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 602,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 602,
        message: "some thing wrong",
        data: null);
  }

  static Future<Result<User>> fetchUser({bool hardFetch = false}) async {
    if (_user != null && !hardFetch) {
      return Result(data: _user, hasError: false, message: "successful");
    }

    late Response? response;
    try {
      response = await HttpProvider.post("auth/me");
      _user = User.fromJson(response?.data["user"]);
      return Result(
          data: _user,
          hasError: false,
          statusCode: response?.statusCode,
          message: "successful");
    } catch (error) {
      return Result(
          hasError: true,
          statusCode: 603,
          message: error.toString(),
          data: null);
    }
  }

  static Future<List<String>?> fetchCachedCredentials() async {
    _prefs = await SharedPreferences.getInstance();
    List<String>? credentials = _prefs?.getStringList("credentials");
    return credentials;
  }
}
