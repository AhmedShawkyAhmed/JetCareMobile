import 'package:flutter/material.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CalenderItemView extends StatelessWidget {
  final String day;
  Color? color;

  CalenderItemView({
    Key? key,
    required this.day,
    this.color,
  }) : super(key: key);

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
