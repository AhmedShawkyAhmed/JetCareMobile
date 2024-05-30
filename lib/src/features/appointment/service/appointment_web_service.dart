import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/features/appointment/data/models/calendar_model.dart';
import 'package:jetcare/src/features/appointment/data/models/period_model.dart';
import 'package:jetcare/src/features/appointment/data/models/space_model.dart';
import 'package:retrofit/retrofit.dart';

part 'appointment_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class AppointmentWebService {
  factory AppointmentWebService(Dio dio, {String baseUrl}) = _AppointmentWebService;

  @GET(EndPoints.getPeriods)
  Future<NetworkBaseModel<List<PeriodModel>>> getPeriods();

  @GET(EndPoints.getSpaces)
  Future<NetworkBaseModel<List<SpaceModel>>> getSpaces({
    @Query('package_id') int? packageId,
  });

  @GET(EndPoints.getCalendar)
  Future<NetworkBaseModel<List<CalendarModel>>> getCalendar({
    @Query('month') int? month,
    @Query('year') int? year,
  });
}
