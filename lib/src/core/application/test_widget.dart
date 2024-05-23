import 'package:flutter/material.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      decoration: const BoxDecoration(color: AppColors.black),
      child: Center(
        child: Text(
          'Version ${packageInfo.version}',
          style: TextStyle(
                color: AppColors.white,
                fontSize: 8.sp,
              ),
        ),
      ),
    );
  }
}
