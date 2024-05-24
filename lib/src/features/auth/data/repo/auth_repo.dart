import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';
import 'package:jetcare/src/features/auth/service/auth_web_service.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';

class AuthRepo {
  final AuthWebService webService;

  AuthRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<UserModel>>> login({
    required LoginRequest request,
  }) async {
    try {
      var response = await webService.login(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }


  Future<NetworkResult<NetworkBaseModel>> fcm({
    required FCMRequest request,
  }) async {
    try {
      var response = await webService.fcm(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
