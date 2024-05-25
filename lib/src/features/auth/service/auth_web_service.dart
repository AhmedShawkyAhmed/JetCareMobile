import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetcare/src/features/auth/data/requests/forget_password_request.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';
import 'package:jetcare/src/features/auth/data/requests/mail_request.dart';
import 'package:jetcare/src/features/auth/data/requests/register_request.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class AuthWebService {
  factory AuthWebService(Dio dio, {String baseUrl}) = _AuthWebService;

  @POST(EndPoints.checkEmail)
  Future<NetworkBaseModel> checkEmail({
    @Body() MailRequest? request,
  });

  @POST(EndPoints.verifyEmail)
  Future<NetworkBaseModel> verifyEmail({
    @Body() MailRequest? request,
  });

  @POST(EndPoints.validateCode)
  Future<NetworkBaseModel> validateCode({
    @Body() MailRequest? request,
  });

  @POST(EndPoints.login)
  Future<NetworkBaseModel<UserModel>> login({
    @Body() LoginRequest? request,
  });

  @POST(EndPoints.register)
  Future<NetworkBaseModel<UserModel>> register({
    @Body() RegisterRequest? request,
  });

  @POST(EndPoints.resetPassword)
  Future<NetworkBaseModel> resetPassword({
    @Body() LoginRequest? request,
  });

  @POST(EndPoints.forgetPassword)
  Future<NetworkBaseModel> forgetPassword({
    @Body() ForgetPasswordRequest? request,
  });

  @POST(EndPoints.updateFCM)
  Future<NetworkBaseModel> fcm({
    @Body() FCMRequest? request,
  });

  @GET(EndPoints.logout)
  Future<NetworkBaseModel> logout();
}
