import 'package:dio/dio.dart';

import 'default_headers_interceptor.dart';
import 'end_points.dart';

class DioHelper {
  DioHelper._();

  static Dio get dio => _initializeDioIfNeeded();
  static Dio? _dio;

  static Dio _initializeDioIfNeeded() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: EndPoints.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 30),
          sendTimeout: null,
        ),
      );
      _dio!.interceptors.addAll([
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
        ),
        DefaultHeadersInterceptor(dio: dio)
      ]);
    }
    return _dio!;
  }
}
