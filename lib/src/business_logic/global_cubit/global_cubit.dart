import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/network/requests/support_request.dart';
import 'package:jetcare/src/data/network/responses/area_response.dart';
import 'package:jetcare/src/data/network/responses/global_response.dart';
import 'package:jetcare/src/data/network/responses/home_response.dart';
import 'package:jetcare/src/data/network/responses/info_response.dart';
import 'package:jetcare/src/data/network/responses/period_response.dart';
import 'package:jetcare/src/data/network/responses/spaces_response.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit(this.networkService) : super(GlobalInitial());
  NetworkService networkService;

  HomeResponse? homeResponse;
  InfoResponse? infoResponse;
  AreaResponse? areaResponse;
  PeriodResponse? periodResponse;
  GlobalResponse? globalResponse;
  SpaceResponse? spaceResponse;
  List<String> days = [], dates = [];

  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        printSuccess('Internet Connected');
        CacheService.add(key: CacheKeys.isConnected, value: true);
      }
    } on SocketException catch (_) {
      CacheService.add(key: CacheKeys.isConnected, value: false);
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
      await networkService
          .get(
        url: EndPoints.getHome,
      )
          .then((value) {
        homeResponse = HomeResponse.fromJson(value.data);
        printSuccess("Home Response ${homeResponse!.status.toString()}");
        emit(HomeSuccessState());
      });
    } on DioException catch (n) {
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
      await networkService
          .get(
        url: EndPoints.getAppInfo,
      )
          .then((value) {
        infoResponse = InfoResponse.fromJson(value.data);
        printSuccess("Info Response ${infoResponse!.status.toString()}");
        emit(InfoSuccessState());
      });
    } on DioException catch (n) {
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
      await networkService
          .get(
        url: EndPoints.getAreas,
      )
          .then((value) {
        areaResponse = AreaResponse.fromJson(value.data);
        printSuccess("Area Response ${areaResponse!.status.toString()}");
        emit(AreaSuccessState());
      });
    } on DioException catch (n) {
      emit(AreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AreaErrorState());
      printError(e.toString());
    }
  }

  Future getPeriods() async {
    try {
      emit(PeriodLoadingState());
      await networkService
          .get(
        url: EndPoints.getPeriods,
      )
          .then((value) {
        periodResponse = PeriodResponse.fromJson(value.data);
        printSuccess("Period Response ${periodResponse!.status.toString()}");
        emit(PeriodSuccessState());
      });
    } on DioException catch (n) {
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
      await networkService.get(url: EndPoints.getSpaces, query: {
        "packageId": packageId,
      }).then((value) {
        spaceResponse = SpaceResponse.fromJson(value.data);
        printSuccess("Space Response ${spaceResponse!.status.toString()}");
        emit(SpaceSuccessState());
      });
    } on DioException catch (n) {
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
      await networkService.post(url: EndPoints.addSupport, body: {
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
    } on DioException catch (n) {
      emit(SupportErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SupportErrorState());
      printError(e.toString());
    }
  }
}
