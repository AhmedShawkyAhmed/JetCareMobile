import 'package:flutter/material.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class DefaultAppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? buttonColor;
  final Color? shadowColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? radius;
  final double? spreadRadius;
  final double? blurRadius;
  final Offset? offset;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<Color>? gradientColors;
  final bool isGradient;
  final bool haveShadow;
  final double? marginHorizontal;
  final double? marginVertical;

  const DefaultAppButton({
    required this.title,
    required this.onTap,
    this.buttonColor,
    this.textColor,
    this.width,
    this.height,
    this.radius,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.begin,
    this.end,
    this.offset,
    this.gradientColors,
    this.shadowColor,
    this.spreadRadius,
    this.blurRadius,
    this.marginHorizontal,
    this.marginVertical,
    this.isGradient = false,
    this.haveShadow = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 80.w,
        height: height ?? 5.h,
        margin: EdgeInsets.symmetric(
            horizontal: marginHorizontal ?? 10.w,
            vertical: marginVertical ?? 2.h),
        decoration: BoxDecoration(
          gradient: isGradient
              ? LinearGradient(
                  begin: begin ?? Alignment.centerLeft,
                  end: end ?? Alignment.centerRight,
                  colors: gradientColors ?? [AppColors.pc2, AppColors.pc1],
                )
              : LinearGradient(
                  colors: [
                    buttonColor ?? AppColors.pc2,
                    buttonColor ?? AppColors.pc1,
                  ],
                ),
          boxShadow: [
            haveShadow
                ? BoxShadow(
                    color: shadowColor ?? AppColors.white.withOpacity(0.2),
                    spreadRadius: spreadRadius ?? 2,
                    blurRadius: blurRadius ?? 2,
                    offset: offset ??
                        const Offset(1, 1), // changes position of shadow
                  )
                : const BoxShadow(),
          ],
          borderRadius: BorderRadius.circular(radius ?? 12),
          color: buttonColor ?? AppColors.pc,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 10.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
              decoration: textDecoration ?? TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
