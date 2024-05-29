import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';
import 'package:jetcare/src/features/address/data/requests/address_request.dart';
import 'package:jetcare/src/features/address/service/address_web_service.dart';

class AddressRepo {
  final AddressWebService webService;

  AddressRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<AddressModel>>> addAddress({
    required AddressRequest request,
  }) async {
    try {
      var response = await webService.addAddress(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateAddress({
    AddressRequest? request,
  }) async {
    try {
      var response = await webService.updateAddress(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteAddress({
    required int id,
  }) async {
    try {
      var response = await webService.deleteAddress(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<AddressModel>>>>
      getMyAddresses() async {
    try {
      var response = await webService.getMyAddresses(
        userId: Globals.userData.id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<AreaModel>>>> getStates() async {
    try {
      var response = await webService.getStates();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<AreaModel>>>> getAreasOfState({
    required int stateId,
  }) async {
    try {
      var response = await webService.getAreasOfState(stateId: stateId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
