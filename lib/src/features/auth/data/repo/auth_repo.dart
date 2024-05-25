import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetcare/src/features/auth/data/requests/forget_password_request.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';
import 'package:jetcare/src/features/auth/data/requests/mail_request.dart';
import 'package:jetcare/src/features/auth/data/requests/register_request.dart';
import 'package:jetcare/src/features/auth/service/auth_web_service.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';

class AuthRepo {
  final AuthWebService webService;

  AuthRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel>> checkEmail({
    required MailRequest request,
  }) async {
    try {
      var response = await webService.checkEmail(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> verifyEmail({
    required MailRequest request,
  }) async {
    try {
      var response = await webService.verifyEmail(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> validateCode({
    required MailRequest request,
  }) async {
    try {
      var response = await webService.validateCode(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

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

  Future<NetworkResult<NetworkBaseModel<UserModel>>> register({
    required RegisterRequest request,
  }) async {
    try {
      var response = await webService.register(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> resetPassword({
    required LoginRequest request,
  }) async {
    try {
      var response = await webService.resetPassword(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> forgetPassword({
    required ForgetPasswordRequest request,
  }) async {
    try {
      var response = await webService.forgetPassword(
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

  Future<NetworkResult<NetworkBaseModel>> logout() async {
    try {
      var response = await webService.logout();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
