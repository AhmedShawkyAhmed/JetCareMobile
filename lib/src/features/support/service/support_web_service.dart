import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/support/data/models/info_model.dart';
import 'package:jetcare/src/features/support/data/requests/support_request.dart';
import 'package:retrofit/retrofit.dart';

part 'support_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SupportWebService {
  factory SupportWebService(Dio dio, {String baseUrl}) = _SupportWebService;

  @GET(EndPoints.getTerms)
  Future<NetworkBaseModel<InfoModel>> getTerms();

  @GET(EndPoints.getAbout)
  Future<NetworkBaseModel<InfoModel>> getAbout();

  @GET(EndPoints.getContact)
  Future<NetworkBaseModel<InfoModel>> getContact();

  @POST(EndPoints.addSupport)
  Future<NetworkBaseModel> addSupport({
    @Body() SupportRequest? request,
  });
}
