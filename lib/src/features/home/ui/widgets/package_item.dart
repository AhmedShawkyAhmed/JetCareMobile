import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class PackageItem extends StatelessWidget {
  final String title;

  const PackageItem({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle_rounded,
            color: AppColors.primary,
            size: 12.sp,
          ),
          SizedBox(width: 2.w),
          SizedBox(
            width: 80.w,
            child: DefaultText(
              text: title,
              maxLines: 10,
              fontSize: 12.sp,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
