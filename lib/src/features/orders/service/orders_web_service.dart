import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/orders/data/requests/order_request.dart';
import 'package:jetcare/src/features/shared/models/order_model.dart';
import 'package:retrofit/retrofit.dart';

part 'orders_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class OrdersWebService {
  factory OrdersWebService(Dio dio, {String baseUrl}) = _OrdersWebService;

  @GET(EndPoints.getMyOrders)
  Future<NetworkBaseModel<List<OrderModel>>> getMyOrders({
    @Query("user_id") int? userId,
});

  @POST(EndPoints.createOrder)
  Future<NetworkBaseModel> createOrder({
    @Body() OrderRequest? request,
  });

  @POST(EndPoints.cancelOrder)
  Future<NetworkBaseModel> cancelOrder({
    @Part(name: "order_id") int? orderId,
    @Part(name: "reason") String? reason,
  });

  @POST(EndPoints.deleteOrder)
  Future<NetworkBaseModel> deleteOrder({
    @Part(name: "order_id") int? orderId,
  });
}
