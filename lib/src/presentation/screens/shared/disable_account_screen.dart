import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class DisableAccountScreen extends StatelessWidget {
  const DisableAccountScreen({Key? key}) : super(key: key);

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
              child: Image.asset("assets/images/block.png"),
            ),
            SizedBox(
              height: 5.h,
            ),
             DefaultText(
              text: translate(AppStrings.stopped),
            ),
            const Spacer(),
            DefaultAppButton(
              title: translate(AppStrings.contactUs),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouterNames.contact,
                  arguments: AppRouterArgument(
                    type: "support",
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
