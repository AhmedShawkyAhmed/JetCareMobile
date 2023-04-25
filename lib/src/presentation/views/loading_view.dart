import 'package:flutter/material.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class LoadingView extends StatelessWidget {
  final double? width;
  final double? height;

  const LoadingView({
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerMain,
          highlightColor: AppColors.shimmerSub,
          child: Container(
            width: width ?? 100.w,
            height: height ?? 20.h,
            margin: EdgeInsets.symmetric(
              vertical: 2.h,
              horizontal: 1.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.pc,
            ),
          ),
        ),
      ),
    );
  }
}
