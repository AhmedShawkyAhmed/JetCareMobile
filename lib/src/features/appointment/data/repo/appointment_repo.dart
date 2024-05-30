import 'package:dio/dio.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/network/models/network_result.dart';
import 'package:jetcare/src/features/appointment/data/models/calendar_model.dart';
import 'package:jetcare/src/features/appointment/data/models/period_model.dart';
import 'package:jetcare/src/features/appointment/data/models/space_model.dart';
import 'package:jetcare/src/features/appointment/service/appointment_web_service.dart';

class AppointmentRepo {
  final AppointmentWebService webService;

  AppointmentRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<PeriodModel>>>>
      getPeriods() async {
    try {
      var response = await webService.getPeriods();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<SpaceModel>>>> getSpaces({
    required int packageId,
  }) async {
    try {
      var response = await webService.getSpaces(packageId: packageId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<CalendarModel>>>> getCalendar({
    required int month,
    required int year,
  }) async {
    try {
      var response = await webService.getCalendar(
        month: month,
        year: year,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
