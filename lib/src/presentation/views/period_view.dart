import 'package:flutter/material.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class PeriodView extends StatelessWidget {
  final String from, to;
  String? unit;
  Color? color;

  PeriodView({
    required this.from,
    required this.to,
    this.unit,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? AppColors.shade.withOpacity(0.1),
      ),
      child: Center(
        child: Text(
          "$from  - $to  ${unit ?? ""}",
          style: TextStyle(
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
          textDirection:TextDirection.ltr,
        ),
      ),
    );
  }
}
