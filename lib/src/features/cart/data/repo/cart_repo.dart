import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/cart/data/models/cart_item_model.dart';
import 'package:jetcare/src/features/cart/data/requests/cart_request.dart';
import 'package:jetcare/src/features/cart/service/cart_web_service.dart';

class CartRepo {
  final CartWebService webService;

  CartRepo(this.webService);


  Future<NetworkResult<NetworkBaseModel>> addToCart({
    required CartRequest request,
  }) async {
    try {
      var response = await webService.addToCart(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }


  Future<NetworkResult<NetworkBaseModel>> deleteFromCart({
    required int id,
  }) async {
    try {
      var response = await webService.deleteFromCart(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }


  Future<NetworkResult<NetworkBaseModel<List<CartItemModel>>>> getMyCart() async {
    try {
      var response = await webService.getMyCart(userId: Globals.userData.id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
