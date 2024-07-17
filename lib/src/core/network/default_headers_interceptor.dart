import 'package:dio/dio.dart';
import 'package:jetcare/src/core/caching/database_helper.dart';
import 'package:jetcare/src/core/caching/database_keys.dart';

class DefaultHeadersInterceptor extends Interceptor {
  final Dio dio;

  DefaultHeadersInterceptor({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'Accept': 'application/json',
      'Authorization':
          "Bearer ${DatabaseHelper.getItem(boxName: DatabaseBox.appBox, key: DatabaseKey.token)}",
    });
    return handler.next(options);
  }
}
