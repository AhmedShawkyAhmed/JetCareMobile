import 'package:flutter/material.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/network/requests/auth_request.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    if (CacheService.get(
            key: CacheKeys.language) ==
        null) {
      CacheService.add(
          key: CacheKeys.language, value: "ar");
    }
    printResponse(CacheService.get(
            key: CacheKeys.phone) ??
        "");
    CacheService.get(
                key: CacheKeys.password) ==
            null
        ? GlobalCubit(instance()).navigate(
            afterSuccess: () {
              NavigationService.pushReplacementNamed(AppRouterNames.login);
            },
          )
        : AuthCubit(instance()).login(
            authRequest: AuthRequest(
                phone: CacheService.get(
                    key: CacheKeys.phone),
                password: CacheService.get(
                    key: CacheKeys.password)),
            client: () {
              GlobalCubit(instance()).navigate(
                afterSuccess: () {
                  NavigationService.pushReplacementNamed(AppRouterNames.layout);
                },
              );
              AuthCubit(instance()).updateFCM(
                id: globalAccountModel.id!,
                fcm: fcmToken!,
              );
            },
            disable: () {
              NavigationService.pushNamedAndRemoveUntil(
                AppRouterNames.disable,
                (route) => false,
              );
            },
            afterFail: () {
              NavigationService.pushReplacementNamed(AppRouterNames.login);
            },
            crew: () {
              GlobalCubit(instance()).navigate(
                afterSuccess: () {
                  NavigationService.pushReplacementNamed(
                      AppRouterNames.crewLayout);
                },
              );
              AuthCubit(instance()).updateFCM(
                id: globalAccountModel.id!,
                fcm: fcmToken!,
              );
            },
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Center(
          child: Image.asset(
            "assets/images/translogow.png",
            width: 70.w,
          ),
        ),
      ),
    );
  }
}
