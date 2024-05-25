import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/profile/data/requests/update_profile_request.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ProfileWebService {
  factory ProfileWebService(Dio dio, {String baseUrl}) = _ProfileWebService;

  @POST(EndPoints.updateProfile)
  Future<NetworkBaseModel> updateProfile({
    @Body() UpdateProfileRequest? request,
  });

  @GET(EndPoints.profile)
  Future<NetworkBaseModel<UserModel>> profile();

  @GET(EndPoints.deleteAccount)
  Future<NetworkBaseModel> deleteAccount();

  @GET(EndPoints.restoreAccount)
  Future<NetworkBaseModel> restoreAccount();
}
