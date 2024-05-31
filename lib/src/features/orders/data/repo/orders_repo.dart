import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/orders/data/requests/order_request.dart';
import 'package:jetcare/src/features/orders/service/orders_web_service.dart';
import 'package:jetcare/src/features/shared/models/order_model.dart';

class OrdersRepo {
  final OrdersWebService webService;

  OrdersRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<OrderModel>>>>
      getMyOrders() async {
    try {
      var response = await webService.getMyOrders(userId: Globals.userData.id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> createOrder({
    required OrderRequest request,
  }) async {
    try {
      var response = await webService.createOrder(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> cancelOrder({
    required int orderId,
    required String reason,
  }) async {
    try {
      var response = await webService.cancelOrder(
        orderId: orderId,
        reason: reason,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteOrder({
    required int orderId,
  }) async {
    try {
      var response = await webService.deleteOrder(orderId: orderId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
