import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/structures/user_structure.dart';

class UserModel {
  static User? _user;
  static final _dio = Dio();

  static Future<bool> userLogin(String id, String password) async {
    bool responseStat = false;
    late Response response;
    try {
      response = await _dio.post("${dotenv.env["ApiUrl"]}/auth/login",
          data: {"email": "shehab8@gmail.com", "password": "12345678"});
      dotenv.env["AccessToken"] = response.data["token"]["original"]["access_token"];
      _user = userResponseToUser(response.data);
      responseStat = true;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return responseStat;
  }

  static Future<User> fetchUser() async{
    if (_user != null) {
      return _user!;
    }

    late Response response;
    try {
      response = await _dio.post("${dotenv.env["ApiUrl"]}/auth/me",
      options: Options(
        headers: {
        }
      ));
      _user = userResponseToUser(response.data);
    } catch (error) {
      throw Exception(error);
    }
    return _user!;
  }

  static User userResponseToUser(Map<String, dynamic> response) {
    User user = User(
      id: RxInt(response['user']['id']??0),
      name: RxString(response['user']['name']??""),
      email: RxString(response['user']['email']??""),
      phone: RxString(response['user']['phone']??""),
      //profileImage: RxString(response['user']['profileImage']??""),
      emailVerifiedAt: RxString(response['user']['email_verified_at']??""),
      createdAt: RxString(response['user']['created_at']??""),
      updatedAt: RxString(response['user']['updated_at']??""),
    );
    return user;
  }

  static void write() {}
}
