import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/shared/models/order_model.dart';
import 'package:jetcare/src/features/crew/data/requests/update_order_status_request.dart';
import 'package:retrofit/retrofit.dart';

part 'crew_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class CrewWebService {
  factory CrewWebService(Dio dio, {String baseUrl}) = _CrewWebService;

  @POST(EndPoints.updateOrderStatus)
  Future<NetworkBaseModel> updateOrderStatus({
    @Body() UpdateOrderStatusRequest? request,
  });

  @POST(EndPoints.rejectOrder)
  Future<NetworkBaseModel> rejectOrder({
    @Part(name: "order_id") int? orderId,
  });

  @GET(EndPoints.getMyTasks)
  Future<NetworkBaseModel<List<OrderModel>>> getMyTasks();

  @GET(EndPoints.getMyTasks)
  Future<NetworkBaseModel<List<OrderModel>>> getMyTasksHistory();
}
