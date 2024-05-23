import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class BackgroundViewWeb extends StatelessWidget {
  const BackgroundViewWeb({required this.widget, super.key});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 1920,
          height: 1080,
          decoration: const BoxDecoration(
            color: AppColors.mainColor,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 80,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 70,
            height: 85,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 100,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 90,
            height: 85,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 1920,
          width: 1080.w,
          child: widget,
        ),
      ],
    );
  }
}
