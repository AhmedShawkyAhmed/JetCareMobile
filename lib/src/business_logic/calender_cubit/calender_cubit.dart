import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/network/api_consumer.dart';
import 'package:jetcare/src/data/models/calender_model.dart';
import 'package:jetcare/src/data/network/responses/calender_response.dart';

import '../../core/network/end_points.dart';
import '../../core/utils/shared_methods.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit(this.networkService) : super(CalenderInitial());
  ApiConsumer networkService;

  CalenderResponse? calenderResponse;
  List<CalenderModel> calenderList = [];

  Future getCalender({
    int? year,
    int? month,
  }) async {
    try {
      emit(GetCalenderInitial());
      await networkService.get(
        url: EndPoints.getCalender,
        query: {
          "month": month ?? DateTime.now().month.toString(),
          "year": year ?? DateTime.now().year.toString(),
        },
      ).then((value) {
        calenderResponse = CalenderResponse.fromJson(value.data);
        calenderList.clear();
        calenderList.addAll(calenderResponse!.calenderModel!);
        emit(GetCalenderSuccess());
      });
    } on DioException catch (n) {
      emit(GetCalenderError());
      printError(n.toString());
    } catch (e) {
      emit(GetCalenderError());
      printError(e.toString());
    }
  }
}
