import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/features/appointment/data/models/calendar_model.dart';
import 'package:jetcare/src/features/appointment/data/models/period_model.dart';
import 'package:jetcare/src/features/appointment/data/models/space_model.dart';
import 'package:jetcare/src/features/appointment/data/repo/appointment_repo.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this.repo) : super(CalendarInitial());
  final AppointmentRepo repo;

  List<PeriodModel> periods = [];
  List<SpaceModel> spaces = [];
  List<CalendarModel> calendar = [];

  Future getPeriods() async {
    periods.clear();
    emit(GetPeriodsLoading());
    var response = await repo.getPeriods();
    response.when(
      success: (NetworkBaseModel response) async {
        periods = response.data;
        emit(GetPeriodsSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetPeriodsFailure());
      },
    );
  }

  Future getSpaces({
    required int packageId,
  }) async {
    spaces.clear();
    emit(GetSpacesLoading());
    var response = await repo.getSpaces(packageId: packageId);
    response.when(
      success: (NetworkBaseModel response) async {
        spaces = response.data;
        emit(GetSpacesSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetSpacesFailure());
      },
    );
  }

  Future getCalendar({
    int? month,
    int? year,
  }) async {
    calendar.clear();
    emit(GetCalendarLoading());
    var response = await repo.getCalendar(
      month: month ?? DateTime.now().month,
      year: year ?? DateTime.now().year,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        calendar = response.data;
        emit(GetCalendarSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetCalendarFailure());
      },
    );
  }
}
