import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 20.h,
              child: Image.asset("assets/images/goodbye.png"),
            ),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
              width: 80.w,
              child: DefaultText(
                text: translate(AppStrings.welcome),
                fontSize: 25.sp,
                maxLines: 5,
                align: TextAlign.center,
              ),
            ),
            const Spacer(),
            DefaultAppButton(
              title: translate(AppStrings.start),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouterNames.layout,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
