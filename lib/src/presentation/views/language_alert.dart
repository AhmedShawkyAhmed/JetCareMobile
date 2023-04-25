import 'package:flutter/material.dart';
import 'package:jetcare/src/business_logic/language_cubit/language_cubit.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class LanguageAlert extends StatelessWidget {
  const LanguageAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        width: 100.w,
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DefaultText(
              text: "العربية",
              onTap: CacheHelper.getDataFromSharedPreference(
                          key: SharedPreferenceKeys.language) ==
                      "ar"
                  ? null
                  : () {
                      LanguageCubit.get(context).toArabic(
                        afterSuccess: () {
                          Navigator.pushNamedAndRemoveUntil(context, AppRouterNames.splash, (route) => false);
                        },
                      );
                    },
              textColor: CacheHelper.getDataFromSharedPreference(
                          key: SharedPreferenceKeys.language) ==
                      "ar"
                  ? AppColors.silver
                  : AppColors.white,
            ),
            DefaultText(
              text: "English",
              onTap: CacheHelper.getDataFromSharedPreference(
                          key: SharedPreferenceKeys.language) ==
                      "ar"
                  ? () {
                LanguageCubit.get(context).toEnglish(
                  afterSuccess: () {
                    Navigator.pushNamedAndRemoveUntil(context, AppRouterNames.splash, (route) => false);
                  },
                );
              }
                  : null,
              textColor: CacheHelper.getDataFromSharedPreference(
                          key: SharedPreferenceKeys.language) ==
                      "ar"
                  ? AppColors.white
                  : AppColors.silver,
            ),
          ],
        ),
      ),
    );
  }
}
