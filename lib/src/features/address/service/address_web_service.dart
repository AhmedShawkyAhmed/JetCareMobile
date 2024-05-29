import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';
import 'package:jetcare/src/features/address/data/requests/address_request.dart';
import 'package:retrofit/retrofit.dart';

part 'address_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class AddressWebService {
  factory AddressWebService(Dio dio, {String baseUrl}) = _AddressWebService;

  @POST(EndPoints.addAddress)
  Future<NetworkBaseModel<AddressModel>> addAddress({
    @Body() AddressRequest? request,
  });

  @POST(EndPoints.updateAddress)
  Future<NetworkBaseModel> updateAddress({
    @Body() AddressRequest? request,
  });

  @POST(EndPoints.deleteAddress)
  Future<NetworkBaseModel> deleteAddress({
    @Part(name: "id") int? id,
  });

  @GET(EndPoints.getMyAddresses)
  Future<NetworkBaseModel<List<AddressModel>>> getMyAddresses();

  @GET(EndPoints.getStates)
  Future<NetworkBaseModel<List<AreaModel>>> getStates();

  @GET(EndPoints.getAreasOfState)
  Future<NetworkBaseModel<List<AreaModel>>> getAreasOfState({
    @Path("state_id") int? stateId,
  });
}
