import 'package:flutter/material.dart';
import 'package:jetcare/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/network/requests/auth_request.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState() {
    if (CacheHelper.getDataFromSharedPreference(
            key: SharedPreferenceKeys.language) ==
        null) {
      CacheHelper.saveDataSharedPreference(
          key: SharedPreferenceKeys.language, value: "ar");
    }
    printResponse(CacheHelper.getDataFromSharedPreference(
            key: SharedPreferenceKeys.phone) ??
        "");
    CacheHelper.getDataFromSharedPreference(
                key: SharedPreferenceKeys.password) ==
            null
        ? GlobalCubit.get(context).navigate(
            afterSuccess: () {
              Navigator.pushReplacementNamed(context, AppRouterNames.login);
            },
          )
        : AuthCubit.get(context).login(
            authRequest: AuthRequest(
                phone: CacheHelper.getDataFromSharedPreference(
                    key: SharedPreferenceKeys.phone),
                password: CacheHelper.getDataFromSharedPreference(
                    key: SharedPreferenceKeys.password)),
            client: () {
              GlobalCubit.get(context).navigate(
                afterSuccess: () {
                  Navigator.pushReplacementNamed(
                      context, AppRouterNames.layout);
                },
              );
            },
            disable: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouterNames.disable,
                (route) => false,
              );
            },
            afterFail: () {
              Navigator.pushReplacementNamed(context, AppRouterNames.login);
            },
            crew: () {
              GlobalCubit.get(context).navigate(
                afterSuccess: () {
                  Navigator.pushReplacementNamed(
                      context, AppRouterNames.crewLayout);
                },
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
