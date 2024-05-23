import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future getFCM() async {
    String? fcm = CacheService.get(key: CacheKeys.fcm);
    if (fcm == null) {
      fcmToken = await FirebaseMessaging.instance.getToken();
      CacheService.add(key: CacheKeys.fcm, value: fcmToken);
      printLog(fcmToken.toString());
    }
  }

  Future<void> init() async {
    String? token = CacheService.get(key: CacheKeys.token);
    await Future.delayed(const Duration(milliseconds: 200), () {
      if (token == null) {
        NavigationService.pushReplacementNamed(Routes.login);
      } else {}
    });
  }
}
