import 'package:dio/dio.dart';
import 'package:jetcare/src/core/caching/database_helper.dart';
import 'package:jetcare/src/core/caching/database_keys.dart';
import 'package:jetcare/src/core/shared/globals.dart';

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
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Globals.userData.token ?? DatabaseHelper.getItem(boxName: DatabaseBox.appBox, key: DatabaseKey.token)}",
    });
    return handler.next(options);
  }
}
