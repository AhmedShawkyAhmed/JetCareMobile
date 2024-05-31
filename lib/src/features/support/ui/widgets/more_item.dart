import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class MoreItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MoreItem({
    required this.onTap,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 8.h,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightGrey.withOpacity(0.5),
              width: 0.2.sp,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.white,
              size: 15.sp,
            ),
            SizedBox(
              width: 3.w,
            ),
            DefaultText(text: title, fontSize: 12.sp),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.white,
              size: 15.sp,
            ),
          ],
        ),
      ),
    );
  }
}
