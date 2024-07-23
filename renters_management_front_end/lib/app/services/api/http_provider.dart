import 'package:dio/dio.dart';

class HttpProvider {
  static final Dio _dio = Dio();
  static InterceptorsWrapper? _authInterceptor;


  static init({String baseUrl = "",String contentType='application/json'}){
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = contentType;
  }


  static Future<Response> get(String url ,{dynamic data}) async {
    try {
      final response = await _dio.get(url,data:data);
      return response;
    } catch (error) {
      // Handle the error
      throw error;
    }
  }

  static Future<Response> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (error) {
      // Handle the error
      throw error;
    }
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
