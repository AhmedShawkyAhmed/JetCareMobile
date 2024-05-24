import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/profile/data/repo/profile_repo.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repo) : super(ProfileInitial());
  ProfileRepo repo;

  Future getProfile() async {
    emit(ProfileLoading());
    var response = await repo.profile();
    response.when(
      success: (NetworkBaseModel response) async {
        Globals.userData = response.data!;
        printSuccess(Globals.userData.role);
        if (Globals.userData.active == 0) {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.disable,
            (route) => false,
          );
        } else if (Globals.userData.archive == 1) {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.deleted,
            (route) => false,
          );
        } else {
          if (Globals.userData.role == Roles.client.name) {
            NavigationService.pushReplacementNamed(Routes.layout);
          } else {
            NavigationService.pushReplacementNamed(Routes.crewLayout);
          }
        }
        emit(ProfileSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(ProfileFailure());
        NavigationService.pushReplacementNamed(Routes.login);
      },
    );
  }

  Future restoreAccount() async {
    IndicatorView.showIndicator();
    emit(RestoreAccountLoading());
    var response = await repo.restoreAccount();
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pushNamedAndRemoveUntil(
          Routes.splash,
          (route) => false,
        );
        emit(RestoreAccountSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        NavigationService.pop();
        emit(RestoreAccountFailure());
      },
    );
  }
}
