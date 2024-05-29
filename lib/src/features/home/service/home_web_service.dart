import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/home/data/models/home_model.dart';
import 'package:jetcare/src/features/home/data/models/package_details_model.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';
import 'package:retrofit/retrofit.dart';

part 'home_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class HomeWebService {
  factory HomeWebService(Dio dio, {String baseUrl}) = _HomeWebService;

  @GET(EndPoints.getHome)
  Future<NetworkBaseModel<HomeModel>> getHome();

  @GET(EndPoints.getPackageDetails)
  Future<NetworkBaseModel<PackageDetailsModel>> getPackageDetails({
    @Query('id') int? id,
  });

  @GET(EndPoints.getCategoryDetails)
  Future<NetworkBaseModel<PackageModel>> getCategoryDetails({
    @Query('id') int? id,
  });
}
