import 'package:flutter/material.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class InfoScreen extends StatelessWidget {
  final AppRouterArgument appRouterArgument;

  const InfoScreen({
    required this.appRouterArgument,
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
            DefaultText(
              text: CacheHelper.getDataFromSharedPreference(
                          key: SharedPreferenceKeys.language) ==
                      "ar"
                  ? appRouterArgument.infoModel!.titleAr.toString()
                  : appRouterArgument.infoModel!.titleEn.toString(),
              fontSize: 20.sp,
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              children: [
                DefaultText(
                  text: CacheHelper.getDataFromSharedPreference(
                              key: SharedPreferenceKeys.language) ==
                          "ar"
                      ? appRouterArgument.infoModel!.contentAr.toString()
                      : appRouterArgument.infoModel!.contentEn.toString(),
                  fontSize: 16.sp,
                  maxLines: 300,
                  fontWeight: FontWeight.w300,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
