import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/home/data/models/home_model.dart';
import 'package:jetcare/src/features/home/data/models/package_details_model.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';
import 'package:jetcare/src/features/home/data/repo/home_repo.dart';
import 'package:jetcare/src/features/shared/views/indicator_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeInitial());
  final HomeRepo repo;

  HomeModel? home;
  PackageDetailsModel? packageDetails;
  PackageModel? category;

  Future getHome() async {
    emit(GetHomeLoading());
    var response = await repo.getHome();
    response.when(
      success: (NetworkBaseModel response) async {
        home = response.data;
        emit(GetHomeSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetHomeFailure());
      },
    );
  }

  Future getPackageDetails({
    required int id,
  }) async {
    IndicatorView.showIndicator();
    emit(GetPackageLoading());
    var response = await repo.getPackageDetails(id: id);
    response.when(
      success: (NetworkBaseModel response) async {
        packageDetails = response.data;
        NavigationService.pop();
        await Future.delayed(const Duration(milliseconds: 100), () {
          NavigationService.pushNamed(
            Routes.package,
            arguments: packageDetails,
          );
        });
        emit(GetPackageSuccess());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        error.showError();
        emit(GetPackageFailure());
      },
    );
  }

  Future getCategoryDetails({
    required int id,
  }) async {
    IndicatorView.showIndicator();
    emit(GetCategoryLoading());
    var response = await repo.getCategoryDetails(id: id);
    response.when(
      success: (NetworkBaseModel response) async {
        category = response.data;
        NavigationService.pop();
        await Future.delayed(const Duration(milliseconds: 100), () {
          NavigationService.pushNamed(
            Routes.category,
            arguments: category,
          );
        });
        emit(GetCategorySuccess());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        error.showError();
        emit(GetCategoryFailure());
      },
    );
  }
}
