import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/corporate/data/models/corporate_model.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CorporateDetailsScreen extends StatelessWidget {
  final CorporateModel corporate;

  const CorporateDetailsScreen({required this.corporate, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: true,
        widget: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: ListView(
            children: [
              CardView(
                image: corporate.item!.image,
                title:
                    isArabic ? corporate.item!.nameAr : corporate.item!.nameEn,
                colorMain: AppColors.primary.withOpacity(0.8),
                colorSub: AppColors.shade.withOpacity(0.4),
                height: 19.h,
                mainHeight: 25.h,
                titleFont: 17.sp,
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                child: DefaultText(
                  text: translate(AppStrings.description),
                ),
              ),
              DefaultText(
                text: isArabic
                    ? "${corporate.item!.descriptionAr}"
                    : "${corporate.item!.descriptionEn}",
                maxLines: 50,
                fontSize: 15.sp,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                child: DefaultText(
                  text: translate(AppStrings.corporateName),
                ),
              ),
              DefaultText(
                text: "${corporate.name}",
                maxLines: 50,
                fontSize: 15.sp,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                child: DefaultText(
                  text: translate(AppStrings.email),
                ),
              ),
              DefaultText(
                text: "${corporate.email}",
                maxLines: 50,
                fontSize: 15.sp,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                child: DefaultText(
                  text: translate(AppStrings.phone),
                ),
              ),
              DefaultText(
                text: "${corporate.phone}",
                maxLines: 50,
                fontSize: 15.sp,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                child: DefaultText(
                  text: translate(AppStrings.message),
                ),
              ),
              DefaultText(
                text: "${corporate.message}",
                maxLines: 50,
                fontSize: 15.sp,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
