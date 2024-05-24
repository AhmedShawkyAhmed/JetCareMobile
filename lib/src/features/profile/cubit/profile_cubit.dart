import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/network_base_model.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.networkService) : super(ProfileInitial());
  NetworkService networkService;

  Future getProfile() async {
    emit(ProfileLoading());
    try {
      await networkService.get(url: EndPoints.profile).then((value) {
        NetworkBaseModel<UserModel> response =
            NetworkBaseModel<UserModel>.fromJson(value.data);
        Globals.userData = response.data!;
        printSuccess(Globals.userData);
        NavigationService.pop();
        if (Globals.userData.active != 1) {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.disable,
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
      });
    } on DioException catch (n) {
      printError(n.toString());
      NavigationService.pushReplacementNamed(Routes.login);
      emit(ProfileFailure());
    } catch (e) {
      printError(e);
      NavigationService.pushReplacementNamed(Routes.login);
      emit(ProfileFailure());
    }
  }
}
