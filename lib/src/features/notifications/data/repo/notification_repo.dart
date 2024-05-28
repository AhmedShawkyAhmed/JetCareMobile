import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/features/notifications/data/models/notification_model.dart';
import 'package:jetcare/src/features/notifications/data/requests/notification_request.dart';
import 'package:jetcare/src/features/notifications/service/notification_web_service.dart';

class NotificationRepo {
  final NotificationWebService webService;

  NotificationRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel>> saveNotification({
    required NotificationRequest request,
  }) async {
    try {
      var response = await webService.saveNotification(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<NotificationModel>>>>
      getNotifications() async {
    try {
      var response = await webService.getNotifications();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> readNotification({
    required int id,
  }) async {
    try {
      var response = await webService.readNotification(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
