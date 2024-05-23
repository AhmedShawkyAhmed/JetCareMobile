import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> post({
    required String url,
    required dynamic body,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> get({
    String url,
    Map<String, dynamic>? query,
  });
}
