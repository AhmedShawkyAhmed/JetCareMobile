import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/features/language/ui/views/language_alert.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/features/shared/ui/views/body_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_app_button.dart';
import 'package:jetcare/src/features/support/ui/widgets/more_item.dart';
import 'package:sizer/sizer.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            if (Globals.userData.role == Roles.client.name)
              MoreItem(
                title: translate(AppStrings.account),
                icon: Icons.person,
                onTap: () {
                  NavigationService.pushNamed(Routes.profile);
                },
              ),
            if (Globals.userData.role == Roles.client.name)
              MoreItem(
                title: translate(AppStrings.addresses),
                icon: Icons.home_work,
                onTap: () {
                  NavigationService.pushNamed(Routes.address);
                },
              ),
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
                  arguments: InfoType.terms,
                );
              },
            ),
            MoreItem(
              title: translate(AppStrings.about),
              icon: Icons.info,
              onTap: () {
                NavigationService.pushNamed(
                  Routes.info,
                  arguments: InfoType.about,
                );
              },
            ),
            MoreItem(
              title: translate(AppStrings.logout),
              icon: Icons.logout_outlined,
              onTap: () {
                AuthCubit(instance()).logout();
              },
            ),
            const Spacer(),
            DefaultAppButton(
              title: translate(AppStrings.deleteAccount),
              buttonColor: AppColors.darkRed,
              onTap: () {
                ProfileCubit(instance()).deleteAccountDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}
