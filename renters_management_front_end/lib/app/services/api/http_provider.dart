import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_x;
import 'package:renters_management_front_end/app/services/api/api_end_points.dart';

class HttpProvider {
  static final Dio _dio = Dio();
  static InterceptorsWrapper? _authInterceptor;

  static init({String baseUrl = "", String contentType = 'application/json'}) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = contentType;
    _dio.options.connectTimeout = const Duration(seconds: 5);
  }

  static Future<Response> get(String url, {dynamic data}) async {
    try {
      final response = await _dio.get(url, data: data);
      return response;
    } on DioException catch (error) {
      // Handle the error
      if (error.response != null) {
        try {
          if (error.response?.statusCode == 405) {
            await _refresh();
            final response = await _dio.get(url, data: data);
            return response;
          }
        } catch (error) {
          if (kDebugMode) {
            print(error);
          }
        }
      }
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  static Future<Response> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on DioException catch (error) {
      // Handle the error
      if (error.response != null) {
        try {
          if (error.response?.statusCode == 405) {
            await _refresh();
            final response = await _dio.post(url, data: data);
            return response;

          }
        } on DioException catch (error) {
          if (kDebugMode) {
            print(error.message);
          }
        }
      }
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  static Future<int> _refresh() async {
    try {
      Response response = await _dio.post(EndPoints.refresh);
      if (response.statusCode == 200) {
        addAuthTokenInterceptor(
            response.data["token"]["original"]["access_token"]);
        return 200;
      } else {
        get_x.Get.offAllNamed("/login");
      }
    } on DioException catch (error) {
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
          get_x.Get.offAllNamed("/login");
        }
      }
    }
    return 405;
  }

  static void addAuthTokenInterceptor(String authToken) {
    _authInterceptor = InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $authToken';
        return handler.next(options);
      },
    );
    _dio.interceptors.add(_authInterceptor!);
  }

  static void removeAuthTokenInterceptor() {
    if (_authInterceptor != null) {
      _dio.interceptors.remove(_authInterceptor);
      _authInterceptor = null;
    }
  }
}
