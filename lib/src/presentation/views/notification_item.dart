import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class NotificationItem extends StatefulWidget {
  final String title;
  final String message;
  final String createdAt;
  final VoidCallback onTap;
  final int isRead;
  final int id;

   const NotificationItem({
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
    required this.id,
    required this.onTap,
    super.key,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 13.h,
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.only(right: 2.h, left: 2.h, bottom: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkGrey.withOpacity(0.5),
          border: Border.all(
            color: widget.isRead == 0?AppColors.primary:AppColors.shade.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.notifications_active,
                color: AppColors.primary,
                size: 15.sp,
              ),
            ),
            SizedBox(
              width: 75.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    text: widget.title,
                    fontSize: 12.sp,
                  ),
                  SizedBox(
                    height: 0.6.h,
                  ),
                  DefaultText(
                    text:
                        widget.message,
                    maxLines: 2,
                    fontSize: 9.sp,
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: DefaultText(
                      text: widget.createdAt,
                      fontSize: 7.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
