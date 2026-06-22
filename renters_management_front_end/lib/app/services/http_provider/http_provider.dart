import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_x;
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pop_up_cards/alert_message_card.dart';
import '../../repositories/user_repository.dart';


class HttpProvider {
  static final Dio _dio = Dio();
  static int _refreshTries = 5;

  static Future<void> init({
    String baseUrl = "",
    String accept = 'application/json',
    String contentType = 'application/json',
    Duration connectTimeout = const Duration(seconds: 15),
    Duration sendTimeout = const Duration(seconds: 60),
    Duration receiveTimeout = const Duration(seconds: 60),
  }) async {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers["Accept"] = accept;
    _dio.options.headers["Content-Type"] = contentType;
    _dio.options.connectTimeout = connectTimeout;
    _dio.options.sendTimeout = sendTimeout;
    _dio.options.receiveTimeout = receiveTimeout;
    if(kIsWeb){
      await reSetAccessToken();
    }
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
        if(error.type == DioExceptionType.receiveTimeout || error.type == DioExceptionType.sendTimeout || error.type == DioExceptionType.connectionTimeout){
          get_x.Get.dialog(PopUpAlertCard(
              "Server Time Out \n  action aborted because take long time place try again later",
              Icons.warning));
          return handler.resolve(
              Response(requestOptions: error.requestOptions, statusCode: 901));
        }
        if (connectivityResult.contains(ConnectivityResult.none)) {
          get_x.Get.dialog(PopUpAlertCard(
              "no internet connection \n please check your connection ",
              Icons.warning));
          return handler.resolve(
              Response(requestOptions: error.requestOptions, statusCode: 900));
        }

        if (error.response?.statusCode == 401 &&
            error.requestOptions.path != "auth/refresh" &&
            error.requestOptions.path != "auth/login") {
          try {
            Response? response = await _refreshAndRetry(error.requestOptions);
            if (response != null) {
              return handler.resolve(response);
            }
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        } else if (((error.response?.statusCode) ?? 0) == 422) {
          return handler.resolve(error.response!);
        }

        if (error.response?.statusCode == 401 &&
            error.requestOptions.path == "refresh"){
          return handler.resolve(error.response!);
        }
        return handler.next(error);
      },
    ));
  }

  static Future<Response?> get(String url, {dynamic data}) async {
    try {
      final response = await _dio.get(url, data: data);
      return response;
    } on DioException catch (error) {
      if (error.response != null) {
        if (kDebugMode) {
          print(error.response?.statusCode);
        }
        return error.response;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  static Future<Response?> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on DioException catch (error) {
      if (error.response != null) {
        if (kDebugMode) {
          print(error.response?.statusCode);
        }
        return error.response;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  static Future<Response?> patch(String url, {dynamic data}) async {
    try {
      final response = await _dio.patch(url, data: data);
      return response;
    } on DioException catch (error) {
      if (error.response != null) {
        if (kDebugMode) {
          print(error.response?.statusCode);
        }
        return error.response;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  static Future<Response?> delete(String url, {dynamic data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return response;
    } on DioException catch (error) {
      if (error.response != null) {
        if (kDebugMode) {
          print(error.response?.statusCode);
        }
        return error.response;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  static Future<Response?> _refreshAndRetry(
      RequestOptions requestOptions) async {
    try {
      _refreshTries--;
      if (_refreshTries < 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("credentials");
        get_x.Get.offAllNamed("login");
        _refreshTries = 5;
        return null;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      addAccessTokenHeader(prefs.getString("refreshToken"));
      Response response = await _dio.post("auth/refresh");
      if (response.statusCode == 401) {
        // re login if remember me data available
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String>? credentials = prefs.getStringList("credentials");
        if (credentials != null) {
          UserServices.userLogin(credentials[0], credentials[1]);
        } else {
          get_x.Get.offAllNamed("login");
        }
      } else if (response.statusCode == 200) {
        addAccessTokenHeader(
            response.data["token"]["original"]["access_token"]
        );
        return await _dio.request(
          requestOptions.path,
          queryParameters: requestOptions.queryParameters,
          data: requestOptions.data,
          options: Options(
            method: requestOptions.method,
          ),
        );
      }
    } on DioException catch (error) {
      return error.response;
    }
    return null;
  }

  static void addAccessTokenHeader(String? accessToken) {
    _dio.options.headers["Authorization"] = "Bearer $accessToken";
    if(kIsWeb){
      storeAccessToken(accessToken??"");
    }
  }

  static void storeRefreshToken(String refreshToken) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("refreshToken",refreshToken);
  }

  static void storeAccessToken(String accessToken) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("AccessToken",accessToken);
  }

  static Future<void> reSetAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _dio.options.headers["Authorization"] = "Bearer ${prefs.getString("AccessToken")}";
  }

  static Future<void> removeAccessToken() async {
    _dio.options.headers["Authorization"] = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("AccessToken");
  }

  static Future<void> removeRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("refreshToken");
  }
}
