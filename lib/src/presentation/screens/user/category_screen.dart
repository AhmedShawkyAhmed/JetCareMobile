import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/details_cubit/details_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/views/home_view.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
                bottom: 3.h,
                top: 5.h
              ),
              child: CardView(
                title: isArabic
                    ? DetailsCubit(instance())
                        .categoryResponse!
                        .categoryModel!
                        .nameAr
                    : DetailsCubit(instance())
                        .categoryResponse!
                        .categoryModel!
                        .nameEn,
                image: DetailsCubit(instance())
                    .categoryResponse!
                    .categoryModel!
                    .image,
                height: 19.h,
                mainHeight: 25.h,
                titleFont: 14.sp,
                colorMain: AppColors.primary.withOpacity(0.8),
                colorSub: AppColors.shade.withOpacity(0.4),
                onTap: () {},
              ),
            ),
            if (DetailsCubit(instance())
                        .categoryResponse!
                        .categoryModel!
                        .descriptionAr !=
                    "" &&
                DetailsCubit(instance())
                        .categoryResponse!
                        .categoryModel!
                        .descriptionAr !=
                    null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultText(
                    text: isArabic
                        ? DetailsCubit(instance())
                            .categoryResponse!
                            .categoryModel!
                            .descriptionAr
                            .toString()
                        : DetailsCubit(instance())
                            .categoryResponse!
                            .categoryModel!
                            .descriptionEn
                            .toString(),
                    fontSize: 12.sp,
                    maxLines: 5,
                  ),
                ],
              ),
            HomeView(
              title: translate(AppStrings.package),
              type: "package",
              visible: DetailsCubit(instance())
                  .categoryResponse!
                  .categoryModel!
                  .packages!
                  .isNotEmpty,
              packageList: DetailsCubit(instance())
                  .categoryResponse!
                  .categoryModel!
                  .packages,
            ),
            SizedBox(
              height: 2.h,
            ),
            HomeView(
              title: translate(AppStrings.items),
              type: "extra",
              visible: DetailsCubit(instance())
                  .categoryResponse!
                  .categoryModel!
                  .items!
                  .isNotEmpty,
              itemList: DetailsCubit(instance())
                  .categoryResponse!
                  .categoryModel!
                  .items,
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
