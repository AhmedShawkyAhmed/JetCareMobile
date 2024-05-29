import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/features/home/data/models/home_model.dart';
import 'package:jetcare/src/features/home/data/models/package_details_model.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';
import 'package:jetcare/src/features/home/service/home_web_service.dart';

class HomeRepo {
  final HomeWebService webService;

  HomeRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<HomeModel>>> getHome() async {
    try {
      var response = await webService.getHome();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<PackageDetailsModel>>>
      getPackageDetails({
    required int id,
  }) async {
    try {
      var response = await webService.getPackageDetails(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<PackageModel>>> getCategoryDetails({
    required int id,
  }) async {
    try {
      var response = await webService.getCategoryDetails(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
