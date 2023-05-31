import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/details_cubit/details_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/views/home_view.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    Key? key,
  }) : super(key: key);

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
                title: CacheHelper.getDataFromSharedPreference(
                            key: SharedPreferenceKeys.language) ==
                        "ar"
                    ? DetailsCubit.get(context)
                        .categoryResponse!
                        .categoryModel!
                        .nameAr
                    : DetailsCubit.get(context)
                        .categoryResponse!
                        .categoryModel!
                        .nameEn,
                image: DetailsCubit.get(context)
                    .categoryResponse!
                    .categoryModel!
                    .image,
                height: 19.h,
                mainHeight: 25.h,
                titleFont: 14.sp,
                colorMain: AppColors.pc.withOpacity(0.8),
                colorSub: AppColors.shade.withOpacity(0.4),
                onTap: () {},
              ),
            ),
            if (DetailsCubit.get(context)
                        .categoryResponse!
                        .categoryModel!
                        .descriptionAr !=
                    "" &&
                DetailsCubit.get(context)
                        .categoryResponse!
                        .categoryModel!
                        .descriptionAr !=
                    null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultText(
                    text: CacheHelper.getDataFromSharedPreference(
                                key: SharedPreferenceKeys.language) ==
                            "ar"
                        ? DetailsCubit.get(context)
                            .categoryResponse!
                            .categoryModel!
                            .descriptionAr
                            .toString()
                        : DetailsCubit.get(context)
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
              visible: DetailsCubit.get(context)
                  .categoryResponse!
                  .categoryModel!
                  .packages!
                  .isNotEmpty,
              packageList: DetailsCubit.get(context)
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
              visible: DetailsCubit.get(context)
                  .categoryResponse!
                  .categoryModel!
                  .items!
                  .isNotEmpty,
              itemList: DetailsCubit.get(context)
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
