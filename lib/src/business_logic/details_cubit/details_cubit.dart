import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/end_points.dart';
import 'package:jetcare/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetcare/src/data/network/responses/category_response.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  static DetailsCubit get(context) => BlocProvider.of(context);

  CategoryResponse? categoryResponse,packageResponse;

  Future getCategory({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DetailsLoadingState());
      await DioHelper.getData(url: EndPoints.getCategoryDetails, query: {
        "id": id,
      }).then((value) {
        printResponse(value.data.toString());
        categoryResponse = CategoryResponse.fromJson(value.data);
        printSuccess(
            "Category Details Response ${categoryResponse!.status.toString()}");
        emit(DetailsSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
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
      await DioHelper.getData(url: EndPoints.getPackageDetails, query: {
        "id": id,
      }).then((value) {
        packageResponse = CategoryResponse.fromJson(value.data);
        printSuccess(
            "Package Details Response ${packageResponse!.status.toString()}");
        emit(PackageSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(PackageErrorState());
      printError(n.toString());
    } catch (e) {
      emit(PackageErrorState());
      printError(e.toString());
    }
  }
}
