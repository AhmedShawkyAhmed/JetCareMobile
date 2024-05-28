import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/features/support/data/models/info_model.dart';
import 'package:jetcare/src/features/support/data/requests/support_request.dart';
import 'package:jetcare/src/features/support/service/support_web_service.dart';

class SupportRepo {
  final SupportWebService webService;

  SupportRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<InfoModel>>> getTerms() async {
    try {
      var response = await webService.getTerms();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<InfoModel>>> getAbout() async {
    try {
      var response = await webService.getAbout();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<InfoModel>>> getContact() async {
    try {
      var response = await webService.getContact();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addSupport({
    required SupportRequest request,
  }) async {
    try {
      var response = await webService.addSupport(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
