import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/cart/data/models/cart_item_model.dart';
import 'package:jetcare/src/features/cart/data/requests/cart_request.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class CartWebService {
  factory CartWebService(Dio dio, {String baseUrl}) = _CartWebService;

  @POST(EndPoints.addToCart)
  Future<NetworkBaseModel> addToCart({
    @Body() CartRequest? request,
  });

  @POST(EndPoints.deleteFromCart)
  Future<NetworkBaseModel> deleteFromCart({
    @Part(name: "id") int? id,
  });

  @GET(EndPoints.getMyCart)
  Future<NetworkBaseModel<List<CartItemModel>>> getMyCart({
    @Query('user_id') int? userId,
  });
}
