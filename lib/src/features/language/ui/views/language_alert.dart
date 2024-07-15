import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/language/cubit/language_cubit.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class LanguageAlert extends StatefulWidget {
  const LanguageAlert({super.key});

  @override
  State<LanguageAlert> createState() => _LanguageAlertState();
}

class _LanguageAlertState extends State<LanguageAlert> {
  LanguageCubit cubit = LanguageCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 2.w),
                    child: GestureDetector(
                      onTap: () => NavigationService.pop(),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              DefaultText(
                text: "العربية",
                onTap: isArabic
                    ? null
                    : () {
                        cubit.changeLanguage();
                      },
                textColor: isArabic ? AppColors.silver : AppColors.white,
              ),
              DefaultText(
                text: "English",
                onTap: isArabic
                    ? () {
                        cubit.changeLanguage();
                      }
                    : null,
                textColor: isArabic ? AppColors.white : AppColors.silver,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
