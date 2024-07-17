import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/src/core/caching/database_helper.dart';
import 'package:jetcare/src/core/caching/database_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> init() async {
    Globals.userData.token = await DatabaseHelper.getItem(
      boxName: DatabaseBox.appBox,
      key: DatabaseKey.token,
    );
    printLog("Token | ${Globals.userData.token}");
    await Future.delayed(const Duration(seconds: 2), () {
      if (Globals.userData.token == null) {
        NavigationService.pushNamedAndRemoveUntil(
            Routes.login, (route) => false);
      } else {
        ProfileCubit(instance()).getProfile();
      }
    });
  }
}
