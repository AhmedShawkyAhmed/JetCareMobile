import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/network/responses/period_response.dart';
import 'package:jetcare/src/data/network/responses/spaces_response.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit(this.networkService) : super(GlobalInitial());
  NetworkService networkService;

  PeriodResponse? periodResponse;
  SpaceResponse? spaceResponse;

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
}
