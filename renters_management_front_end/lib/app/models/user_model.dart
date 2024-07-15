import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/api/api_end_points.dart';
import 'package:renters_management_front_end/app/models/api/http_provider.dart';
import 'package:renters_management_front_end/app/models/structures/user_structure.dart';

class UserModel {
  static User? _user;

  static Future<bool> userLogin(String id, String password) async {
    bool responseStat = false;
    late Response response;
    try {
      response = await HttpProvider.post(EndPoints.login,
          data: {"email": "shehab8@gmail.com", "password": "12345678"});
      _user = userResponseToUser(response.data);
      HttpProvider.addAuthTokenInterceptor(response.data["token"]["original"]["access_token"]);
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
      _user = userResponseToUser(response.data['user']);
    } catch (error) {
      throw Exception(error);
    }
    return _user!;
  }

  static User userResponseToUser(Map<String, dynamic> response) {
    User user = User(
      id: RxInt(response['id'] ?? 0),
      name: RxString(response['name'] ?? ""),
      email: RxString(response['email'] ?? ""),
      phone: RxString(response['phone'] ?? ""),
      //profileImage: RxString(response['profileImage']??""),
      emailVerifiedAt: RxString(response['email_verified_at'] ?? ""),
      createdAt: RxString(response['created_at'] ?? ""),
      updatedAt: RxString(response['updated_at'] ?? ""),
    );
    return user;
  }

  static void write() {}
}
