import 'package:flutter/material.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      decoration: const BoxDecoration(color: AppColors.black),
      child: Center(
        child: DefaultText(
          text: 'Version ${packageInfo.version}',
          fontSize: 8.sp,
          textColor: AppColors.white,
        ),
      ),
    );
  }
}
