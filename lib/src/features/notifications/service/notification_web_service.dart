import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/notifications/data/models/notification_model.dart';
import 'package:jetcare/src/features/notifications/data/requests/notification_request.dart';
import 'package:retrofit/retrofit.dart';

part 'notification_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class NotificationWebService {
  factory NotificationWebService(Dio dio, {String baseUrl}) =
      _NotificationWebService;

  @POST(EndPoints.saveNotification)
  Future<NetworkBaseModel> saveNotification({
    @Body() NotificationRequest? request,
  });

  @GET(EndPoints.getNotifications)
  Future<NetworkBaseModel<List<NotificationModel>>> getNotifications();

  @GET(EndPoints.readNotification)
  Future<NetworkBaseModel> readNotification({
    @Path('id') int? id,
  });
}
