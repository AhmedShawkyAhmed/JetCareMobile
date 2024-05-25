import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

customError() {
  ErrorWidget.builder = (FlutterErrorDetails error) {
    return Scaffold(
      body: BodyView(
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/error.png',width: 50.w),
            ),
            const SizedBox(
              height: 30,
            ),
            DefaultText(
              text: translate(AppStrings.error),
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  };
}
