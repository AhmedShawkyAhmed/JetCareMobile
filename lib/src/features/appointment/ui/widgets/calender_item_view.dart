import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CalenderItemView extends StatelessWidget {
  final String day;
  final Color? color;

  const CalenderItemView({
    super.key,
    required this.day,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.mainColorShade2,
        border: Border.all(color: AppColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: DefaultText(
          text: day,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
