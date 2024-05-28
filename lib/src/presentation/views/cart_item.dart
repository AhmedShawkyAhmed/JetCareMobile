import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CartItem extends StatelessWidget {
  final String name;
  final String count;
  final String price;
  final String image;
  final bool withDelete;
  final VoidCallback onDelete;

  const CartItem({
    required this.price,
    required this.count,
    required this.name,
    required this.image,
    required this.withDelete,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.h,
      padding: EdgeInsets.all(6.sp),
      margin: EdgeInsets.only(right: 1.h, left: 1.h, bottom: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.shade.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 18.w,
            height: 18.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                EndPoints.imageDomain + image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 65.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                  text: name,
                  fontSize: 12.sp,
                  maxLines: 1,
                ),
                DefaultText(
                  text: count,
                  fontSize: 10.sp,
                ),
                DefaultText(
                  text: "$price ${translate(AppStrings.currency)}",
                  fontSize: 10.sp,
                ),
              ],
            ),
          ),
          if(withDelete)...[
            InkWell(
              onTap: onDelete,
              child: Icon(
                Icons.delete_forever,
                color: AppColors.darkRed,
                size: 20.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
