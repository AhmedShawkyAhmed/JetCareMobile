import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/cache_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> init() async {
    String? token = CacheService.get(key: CacheKeys.token);
    printLog("Token | $token");
    await Future.delayed(const Duration(seconds: 2), () {
      if (token == null) {
        NavigationService.pushNamedAndRemoveUntil(
            Routes.login, (route) => false);
      } else {
        ProfileCubit(instance()).getProfile();
      }
    });
  }
}
