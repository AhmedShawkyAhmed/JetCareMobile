import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:sizer/sizer.dart';

class SummeryItem extends StatelessWidget {
  final String title, sub;
  final bool visible;
  final double? padding;

  const SummeryItem({
    required this.title,
    required this.sub,
    required this.visible,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding ?? 8.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20.w,
                  child: DefaultText(
                    text: title,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 60.w,
                  child: DefaultText(
                    text: sub,
                    fontSize: 13.sp,
                    maxLines: 1,
                    align: isArabic
                        ? TextAlign.left
                        : TextAlign.right,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 2.h,
              ),
              height: 1.sp,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
