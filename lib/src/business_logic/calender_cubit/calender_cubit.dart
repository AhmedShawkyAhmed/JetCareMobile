import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/data/models/calender_model.dart';
import 'package:jetcare/src/data/network/responses/calender_response.dart';
import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit() : super(CalenderInitial());

  static CalenderCubit get(context) => BlocProvider.of(context);

  CalenderResponse? calenderResponse;
  List<CalenderModel> calenderList = [];

  Future getCalender({
    int? year,
    int? month,
  }) async {
    try {
      emit(GetCalenderInitial());
      await DioHelper.getData(
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
    } on DioError catch (n) {
      emit(GetCalenderError());
      printError(n.toString());
    } catch (e) {
      emit(GetCalenderError());
      printError(e.toString());
    }
  }
}
