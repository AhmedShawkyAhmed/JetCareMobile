import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/language_alert.dart';
import 'package:jetcare/src/presentation/views/more_item.dart';
import 'package:sizer/sizer.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Column(
          children: [
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 5.w,
            //     ),
            //     Icon(
            //       Icons.star_rate_rounded,
            //       size: 15.sp,
            //       color: AppColors.gold,
            //     ),
            //     SizedBox(
            //       width: 2.w,
            //     ),
            //     DefaultText(
            //       text: globalAccountModel.rate!.toDouble().toString(),
            //       fontSize: 12.sp,
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 4.h,
            ),
            if (globalAccountModel.role == "client")
              MoreItem(
                title: translate(AppStrings.account),
                icon: Icons.person,
                onTap: () {
                  NavigationService.pushNamed(
                    Routes.profile,
                    arguments: AppRouterArgument(
                      type: "profile",
                    ),
                  );
                },
              ),
            if (globalAccountModel.role == "client")
              MoreItem(
                title: translate(AppStrings.addresses),
                icon: Icons.home_work,
                onTap: () {
                  NavigationService.pushNamed(Routes.address);
                },
              ),
            // MoreItem(
            //   title: "Notifications",
            //   icon: Icons.notifications_active,
            //   onTap: () {},
            // ),
            // MoreItem(
            //   title: "PromoCodes",
            //   icon: Icons.discount,
            //   onTap: () {},
            // ),
            MoreItem(
              title: translate(AppStrings.contactUs),
              icon: Icons.support,
              onTap: () {
                NavigationService.pushNamed(Routes.contact);
              },
            ),
            MoreItem(
              title: translate(AppStrings.lang),
              icon: Icons.language,
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return const LanguageAlert();
                  },
                );
              },
            ),
            MoreItem(
              title: translate(AppStrings.terms),
              icon: Icons.note_alt_rounded,
              onTap: () {
                NavigationService.pushNamed(
                  Routes.info,
                  arguments: AppRouterArgument(
                    infoModel: GlobalCubit(instance()).infoResponse!.terms,
                  ),
                );
              },
            ),
            MoreItem(
              title: translate(AppStrings.about),
              icon: Icons.info,
              onTap: () {
                NavigationService.pushNamed(
                  Routes.info,
                  arguments: AppRouterArgument(
                    infoModel: GlobalCubit(instance()).infoResponse!.about,
                  ),
                );
              },
            ),
            MoreItem(
              title: translate(AppStrings.logout),
              icon: Icons.logout_outlined,
              onTap: () {
                CacheService.clear();
                globalAccountModel = UserModel();
                LayoutCubit().currentIndex = 0;
                CacheService.add(key: CacheKeys.language, value: Languages.ar.name);
                NavigationService.pushNamedAndRemoveUntil(
                  Routes.login,
                  (route) => false,
                );
              },
            ),
            const Spacer(),
            DefaultAppButton(
              title: translate(AppStrings.deleteAccount),
              buttonColor: AppColors.darkRed,
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: AppColors.mainColor,
                      title: DefaultText(
                        text: translate(AppStrings.deleteAccount),
                        align: TextAlign.center,
                        fontSize: 19.sp,
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            DefaultText(
                              text: translate(AppStrings.deleteAlert),
                              align: TextAlign.center,
                              fontSize: 15.sp,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      actions: <Widget>[
                        DefaultText(
                          text: translate(AppStrings.deleteAccount),
                          align: TextAlign.center,
                          fontSize: 13.sp,
                          textColor: AppColors.darkRed,
                          onTap: () {
                            // TODO delete account
                            // AuthCubit(instance()).deleteAccount(
                            //   userId: globalAccountModel.id.toString(),
                            //   afterSuccess: () {
                            //     CacheService.clear();
                            //     NavigationService.pushNamedAndRemoveUntil(
                            //       Routes.login,
                            //       (route) => false,
                            //     );
                            //   },
                            // );
                          },
                        ),
                        DefaultText(
                          text: translate(AppStrings.cancel),
                          align: TextAlign.center,
                          fontSize: 13.sp,
                          onTap: () {
                            NavigationService.pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
