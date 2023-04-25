import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/details_cubit/details_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/views/package_item_widget.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:sizer/sizer.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: CardView(
                title: CacheHelper.getDataFromSharedPreference(
                            key: SharedPreferenceKeys.language) ==
                        "ar"
                    ? DetailsCubit.get(context)
                        .packageResponse!
                        .packageModel!
                        .nameAr
                    : DetailsCubit.get(context)
                        .packageResponse!
                        .packageModel!
                        .nameEn,
                image: DetailsCubit.get(context)
                    .packageResponse!
                    .packageModel!
                    .image,
                height: 19.h,
                mainHeight: 25.h,
                titleFont: 17.sp,
                colorMain: AppColors.pc.withOpacity(0.8),
                colorSub: AppColors.shade.withOpacity(0.4),
                onTap: () {},
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                shrinkWrap: true,
                itemCount: DetailsCubit.get(context)
                    .packageResponse!
                    .items!
                    .length,
                itemBuilder: (context, index) {
                  return PackageItem(
                    title: CacheHelper.getDataFromSharedPreference(
                                key: SharedPreferenceKeys.language) ==
                            "ar"
                        ? DetailsCubit.get(context)
                            .packageResponse!
                            .items![index]
                            .nameAr!
                        : DetailsCubit.get(context)
                            .packageResponse!
                            .items![index]
                            .nameEn!,
                  );
                },
              ),
            ),
            DefaultAppButton(
              title: translate(AppStrings.appointment),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouterNames.appointment,
                  arguments: AppRouterArgument(
                    type: "package",
                    packageModel: DetailsCubit.get(context)
                        .packageResponse!
                        .packageModel!,
                  ),
                );
              },
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
