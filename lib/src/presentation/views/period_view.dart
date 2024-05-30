// import 'package:flutter/material.dart';
// import 'package:jetcare/src/core/constants/app_colors.dart';
// import 'package:sizer/sizer.dart';
//
// class PeriodView extends StatelessWidget {
//   final String from, to;
//   final String? unit;
//   final Color? color;
//
//   const PeriodView({
//     required this.from,
//     required this.to,
//     this.unit,
//     this.color,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 45.w,
//       margin: EdgeInsets.only(right: 5.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: color ?? AppColors.shade.withOpacity(0.1),
//       ),
//       child: Center(
//         child: Text(
//           "$from  - $to  ${unit ?? ""}",
//           style: TextStyle(
//             fontSize: 9.sp,
//             fontWeight: FontWeight.w400,
//             color: AppColors.white,
//           ),
//           textDirection: TextDirection.ltr,
//         ),
//       ),
//     );
//   }
// }
