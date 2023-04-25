import 'package:flutter/material.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class IndicatorView {
  static Future showIndicator(BuildContext context) async {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: 20.w,
            height: 20.w,
            child: const CircularProgressIndicator(
              color: AppColors.pc,
            ),
          ),
        );
      },
    );
  }
}
