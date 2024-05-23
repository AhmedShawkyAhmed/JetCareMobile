import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

class InfoScreen extends StatelessWidget {
  final AppRouterArgument appRouterArgument;

  const InfoScreen({
    required this.appRouterArgument,
    super.key,
  });

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
              text: CacheService.get(
                          key: CacheKeys.language) ==
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
                  text: CacheService.get(
                              key: CacheKeys.language) ==
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
