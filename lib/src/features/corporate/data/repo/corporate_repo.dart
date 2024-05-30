import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/corporate/data/models/corporate_model.dart';
import 'package:jetcare/src/features/corporate/data/requests/corporate_request.dart';
import 'package:jetcare/src/features/corporate/service/corporate_web_service.dart';

class CorporateRepo {
  final CorporateWebService webService;

  CorporateRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel>> addCorporateOrder({
    required CorporateRequest request,
  }) async {
    try {
      var response = await webService.addCorporateOrder(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<CorporateModel>>>>
      getMyCorporateOrders() async {
    try {
      var response =
          await webService.getMyCorporateOrders(userId: Globals.userData.id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
