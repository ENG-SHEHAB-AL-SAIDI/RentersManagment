import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpProvider {
  static final Dio _dio = Dio();
  static InterceptorsWrapper? _authInterceptor;

  static init({String baseUrl = "", String contentType = 'application/json'})  {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers["Accept"] = contentType;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
        if (kDebugMode) {
          print("HttpProviderError ------------------ ");
          print("status code: ${error.response?.statusCode}");
          print("status headers: ${error.response?.isRedirect}");
          print(connectivityResult);
        }
        if(connectivityResult.contains(ConnectivityResult.none)){
           return handler.resolve(Response(requestOptions: error.requestOptions,statusCode: 900));
        }
        if (error.response?.statusCode == 401 &&
            error.requestOptions.path != "auth/refresh") {
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
      Response response = await _dio.post("auth/refresh");
      if (response.statusCode == 200) {
        removeAuthTokenInterceptor();
        addAuthTokenInterceptor(
            response.data["token"]["original"]["access_token"]);
        return await _dio.request(requestOptions.path,
            queryParameters: requestOptions.queryParameters,
            data: requestOptions.data,
            options: Options(
              method: requestOptions.method,
            ));
      }
    } on DioException catch (error) {
      return error.response;
    }

    return null;
  }

  static void addAuthTokenInterceptor(String authToken) {
    _dio.options.headers["Authorization"] = "Bearer $authToken";
    // _authInterceptor = InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     options.headers['Authorization'] = 'Bearer $authToken';
    //     return handler.next(options);
    //   },
    // );
    // _dio.interceptors.add(_authInterceptor!);
  }

  static void removeAuthTokenInterceptor() {
    if (_authInterceptor != null) {
      _dio.interceptors.remove(_authInterceptor);
      _authInterceptor = null;
    }
  }
}
