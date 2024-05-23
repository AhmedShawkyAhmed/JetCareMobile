import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/network/api_consumer.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/network/responses/category_response.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.networkService) : super(DetailsInitial());
  ApiConsumer networkService;

  CategoryResponse? categoryResponse,packageResponse;

  Future getCategory({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DetailsLoadingState());
      await networkService.get(url: EndPoints.getCategoryDetails, query: {
        "id": id,
      }).then((value) {
        printResponse(value.data.toString());
        categoryResponse = CategoryResponse.fromJson(value.data);
        printSuccess(
            "Category Details Response ${categoryResponse!.status.toString()}");
        emit(DetailsSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(DetailsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DetailsErrorState());
      printError(e.toString());
    }
  }

  Future getPackage({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(PackageLoadingState());
      await networkService.get(url: EndPoints.getPackageDetails, query: {
        "id": id,
      }).then((value) {
        packageResponse = CategoryResponse.fromJson(value.data);
        printSuccess(
            "Package Details Response ${packageResponse!.status.toString()}");
        emit(PackageSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(PackageErrorState());
      printError(n.toString());
    } catch (e) {
      emit(PackageErrorState());
      printError(e.toString());
    }
  }
}
