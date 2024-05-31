import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/features/shared/models/order_model.dart';
import 'package:jetcare/src/features/crew/data/requests/update_order_status_request.dart';
import 'package:jetcare/src/features/crew/service/crew_web_service.dart';

class CrewRepo {
  final CrewWebService webService;

  CrewRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel>> updateOrderStatus({
    required UpdateOrderStatusRequest request,
  }) async {
    try {
      var response = await webService.updateOrderStatus(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> rejectOrder({
    required int orderId,
  }) async {
    try {
      var response = await webService.rejectOrder(orderId: orderId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<OrderModel>>>> getMyTasks() async {
    try {
      var response = await webService.getMyTasks();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<OrderModel>>>>
      getMyTasksHistory() async {
    try {
      var response = await webService.getMyTasksHistory();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
