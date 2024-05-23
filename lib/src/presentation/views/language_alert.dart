import 'package:flutter/material.dart';
import 'package:jetcare/src/business_logic/language_cubit/language_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class LanguageAlert extends StatelessWidget {
  const LanguageAlert({super.key});

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
              onTap: CacheService.get(
                          key: CacheKeys.language) ==
                      "ar"
                  ? null
                  : () {
                      LanguageCubit().toArabic(
                        afterSuccess: () {
                          NavigationService.pushNamedAndRemoveUntil(Routes.splash, (route) => false);
                        },
                      );
                    },
              textColor: CacheService.get(
                          key: CacheKeys.language) ==
                      "ar"
                  ? AppColors.silver
                  : AppColors.white,
            ),
            DefaultText(
              text: "English",
              onTap: CacheService.get(
                          key: CacheKeys.language) ==
                      "ar"
                  ? () {
                LanguageCubit().toEnglish(
                  afterSuccess: () {
                    NavigationService.pushNamedAndRemoveUntil(Routes.splash, (route) => false);
                  },
                );
              }
                  : null,
              textColor: CacheService.get(
                          key: CacheKeys.language) ==
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
