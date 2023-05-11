import 'package:flutter/material.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class BodyView extends StatelessWidget {
  const BodyView({
    required this.widget,
    this.hasBack = true,
    Key? key,
  }) : super(key: key);
  final Widget widget;
  final bool hasBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.pc1.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 25.w,
              height: 29.w,
              decoration: BoxDecoration(
                color: AppColors.pc.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 18.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: AppColors.pc2.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.pc1.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 26.w,
              height: 29.w,
              decoration: BoxDecoration(
                color: AppColors.pc.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 19.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: AppColors.pc2.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: hasBack ? 10.h : 0),
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: widget,
            ),
          ),
          Visibility(
            visible: hasBack,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 4.h,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.pc,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
