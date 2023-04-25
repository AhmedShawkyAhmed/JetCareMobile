import 'package:flutter/material.dart';
import 'package:jetcare/src/constants/end_points.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CardView extends StatefulWidget {
  const CardView({
    required this.image,
    required this.onTap,
    this.width,
    this.height,
    this.title,
    this.type = "",
    this.content,
    this.colorMain,
    this.colorSub,
    this.contentFont,
    this.textColor,
    this.titleFont,
    this.statusColor,
    this.mainHeight,
    this.status = false,
    Key? key,
  }) : super(key: key);
  final double? width, height, mainHeight;
  final double? titleFont, contentFont;
  final Color? colorMain, colorSub, textColor, statusColor;
  final String? image, title, content, type;
  final bool status;
  final VoidCallback onTap;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.width ?? 100.w,
        height: widget.mainHeight ?? 30.h,
        child: Column(
          children: [
            SizedBox(
              height: widget.height ?? 13.h,
              child: Stack(
                children: [
                  Container(
                    width: widget.width ?? 100.w,
                    height: widget.height ?? 20.h,
                    margin: EdgeInsets.only(
                      left: 1.w,
                      right: 1.w,
                      top: 1.h,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        EndPoints.imageDomain + widget.image!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Center(
                              child: Image.asset(
                                "assets/images/translogow.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: widget.width ?? 100.w,
                    height: widget.height ?? 20.h,
                    margin: EdgeInsets.only(
                      left: 1.w,
                      right: 1.w,
                      top: 1.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.centerLeft,
                        colors: [
                          widget.colorSub ?? AppColors.shade.withOpacity(0.1),
                          widget.colorMain ?? AppColors.pc.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                  if (widget.status)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 5.w,
                        height: 5.w,
                        margin: EdgeInsets.only(
                          top: 1.h,
                          left: 1.w,
                          right: 3.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: widget.statusColor,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.5.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DefaultText(
                  text: widget.title ?? "",
                  align: TextAlign.center,
                  fontSize: widget.titleFont ?? 9.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
