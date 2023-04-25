import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/end_points.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetcare/src/data/network/requests/support_request.dart';
import 'package:jetcare/src/data/network/responses/area_response.dart';
import 'package:jetcare/src/data/network/responses/calendar_response.dart';
import 'package:jetcare/src/data/network/responses/global_response.dart';
import 'package:jetcare/src/data/network/responses/home_response.dart';
import 'package:jetcare/src/data/network/responses/info_response.dart';
import 'package:jetcare/src/data/network/responses/period_response.dart';
import 'package:jetcare/src/data/network/responses/spaces_response.dart';
import 'package:url_launcher/url_launcher.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  HomeResponse? homeResponse;
  InfoResponse? infoResponse;
  AreaResponse? areaResponse;
  CalendarResponse? calendarResponse;
  PeriodResponse? periodResponse;
  GlobalResponse? globalResponse;
  SpaceResponse? spaceResponse;
  List<String> days = [], dates = [];

  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        printSuccess('Internet Connected');
        CacheHelper.saveDataSharedPreference(
            key: SharedPreferenceKeys.isConnected, value: true);
      }
    } on SocketException catch (_) {
      CacheHelper.saveDataSharedPreference(
          key: SharedPreferenceKeys.isConnected, value: false);
      printError('Internet Disconnected');
    }
  }

  Future navigate({required VoidCallback afterSuccess}) async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    afterSuccess();
  }

  Future getHome() async {
    try {
      emit(HomeLoadingState());
      await DioHelper.getData(
        url: EndPoints.getHome,
      ).then((value) {
        homeResponse = HomeResponse.fromJson(value.data);
        printSuccess("Home Response ${homeResponse!.status.toString()}");
        emit(HomeSuccessState());
      });
    } on DioError catch (n) {
      emit(HomeErrorState());
      printError(n.toString());
    } catch (e) {
      emit(HomeErrorState());
      printError(e.toString());
    }
  }

  Future getInfo() async {
    try {
      emit(InfoLoadingState());
      await DioHelper.getData(
        url: EndPoints.getAppInfo,
      ).then((value) {
        infoResponse = InfoResponse.fromJson(value.data);
        printSuccess("Info Response ${infoResponse!.status.toString()}");
        emit(InfoSuccessState());
      });
    } on DioError catch (n) {
      emit(InfoErrorState());
      printError(n.toString());
    } catch (e) {
      emit(InfoErrorState());
      printError(e.toString());
    }
  }

  Future getArea() async {
    try {
      emit(AreaLoadingState());
      await DioHelper.getData(
        url: EndPoints.getAreas,
      ).then((value) {
        areaResponse = AreaResponse.fromJson(value.data);
        printSuccess("Area Response ${areaResponse!.status.toString()}");
        emit(AreaSuccessState());
      });
    } on DioError catch (n) {
      emit(AreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AreaErrorState());
      printError(e.toString());
    }
  }

  Future getCalendar({required int areaId}) async {
    days.clear();
    try {
      emit(CalendarLoadingState());
      await DioHelper.getData(
        url: EndPoints.getDatesMobile,
        query: {
          'areaId': areaId,
        },
      ).then((value) {
        calendarResponse = CalendarResponse.fromJson(value.data);
        printSuccess(
            "Calendar Response ${calendarResponse!.status.toString()}");
        for (int i = 0; i < calendarResponse!.calendar!.length; i++) {
          days.add(calendarResponse!.calendar![i].day.toString());
          dates.add(calendarResponse!.calendar![i].date.toString());
        }
        emit(CalendarSuccessState());
      });
    } on DioError catch (n) {
      emit(CalendarErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CalendarErrorState());
      printError(e.toString());
    }
  }

  Future getPeriods() async {
    try {
      emit(PeriodLoadingState());
      await DioHelper.getData(
        url: EndPoints.getPeriods,
      ).then((value) {
        periodResponse = PeriodResponse.fromJson(value.data);
        printSuccess("Period Response ${periodResponse!.status.toString()}");
        emit(PeriodSuccessState());
      });
    } on DioError catch (n) {
      emit(PeriodErrorState());
      printError(n.toString());
    } catch (e) {
      emit(PeriodErrorState());
      printError(e.toString());
    }
  }

  Future getSpaces({required int packageId}) async {
    try {
      emit(SpaceLoadingState());
      await DioHelper.getData(url: EndPoints.getSpaces, query: {
        "packageId": packageId,
      }).then((value) {
        spaceResponse = SpaceResponse.fromJson(value.data);
        printSuccess("Space Response ${spaceResponse!.status.toString()}");
        emit(SpaceSuccessState());
      });
    } on DioError catch (n) {
      emit(SpaceErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SpaceErrorState());
      printError(e.toString());
    }
  }

  Future support({
    required SupportRequest supportRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SupportLoadingState());
      await DioHelper.postData(url: EndPoints.addSupport, body: {
        'name': supportRequest.name,
        'contact': supportRequest.contact,
        'message': supportRequest.message,
        'subject': supportRequest.subject,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        printSuccess("Support Response ${globalResponse!.status.toString()}");
        emit(SupportSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(SupportErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SupportErrorState());
      printError(e.toString());
    }
  }

  Future<void> openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
