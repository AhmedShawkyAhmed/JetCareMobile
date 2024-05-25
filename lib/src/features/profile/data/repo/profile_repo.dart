import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/features/profile/data/requests/update_profile_request.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';
import 'package:jetcare/src/features/profile/service/profile_web_service.dart';

class ProfileRepo {
  final ProfileWebService webService;

  ProfileRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel>> updateProfile({
    UpdateProfileRequest? request,
  }) async {
    try {
      var response = await webService.updateProfile(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<UserModel>>> profile() async {
    try {
      var response = await webService.profile();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteAccount() async {
    try {
      var response = await webService.deleteAccount();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> restoreAccount() async {
    try {
      var response = await webService.restoreAccount();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
