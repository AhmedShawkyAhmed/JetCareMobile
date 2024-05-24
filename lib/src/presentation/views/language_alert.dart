import 'package:flutter/material.dart';
import 'package:jetcare/src/business_logic/language_cubit/language_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
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
              onTap: isArabic
                  ? null
                  : () {
                      LanguageCubit().changeLanguage();
                    },
              textColor: isArabic ? AppColors.silver : AppColors.white,
            ),
            DefaultText(
              text: "English",
              onTap: isArabic
                  ? () {
                      LanguageCubit().changeLanguage();
                    }
                  : null,
              textColor: isArabic ? AppColors.white : AppColors.silver,
            ),
          ],
        ),
      ),
    );
  }
}
