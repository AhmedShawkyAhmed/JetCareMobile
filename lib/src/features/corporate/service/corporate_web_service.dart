import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/corporate/data/models/corporate_model.dart';
import 'package:jetcare/src/features/corporate/data/requests/corporate_request.dart';
import 'package:retrofit/retrofit.dart';

part 'corporate_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class CorporateWebService {
  factory CorporateWebService(Dio dio, {String baseUrl}) = _CorporateWebService;

  @POST(EndPoints.addCorporateOrder)
  Future<NetworkBaseModel> addCorporateOrder({
    @Body() CorporateRequest? request,
  });

  @GET(EndPoints.getMyCorporateOrders)
  Future<NetworkBaseModel<List<CorporateModel>>> getMyCorporateOrders({
    @Query("user_id") int? userId,
});
}
