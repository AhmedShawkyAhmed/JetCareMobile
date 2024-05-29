// import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:jetcare/src/core/constants/app_colors.dart';
// import 'package:jetcare/src/core/constants/app_strings.dart';
// import 'package:jetcare/src/core/constants/constants_variables.dart';
// import 'package:jetcare/src/core/services/navigation_service.dart';
// import 'package:jetcare/src/features/home/data/models/item_model.dart';
// import 'package:jetcare/src/features/shared/widgets/default_text.dart';
// import 'package:jetcare/src/core/utils/shared_methods.dart';
// import 'package:sizer/sizer.dart';
//
// class ExtraView extends StatefulWidget {
//   final List<ItemModel> extras;
//
//   const ExtraView({
//     required this.extras,
//     super.key,
//   });
//
//   @override
//   State<ExtraView> createState() => _ExtraItemViewState();
// }
//
// class _ExtraItemViewState extends State<ExtraView> {
//   List<bool> isChecked = List.generate(2000, (index) => false);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60.h,
//       color: AppColors.mainColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             height: 2.h,
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 5.w,
//                 ),
//                 child: DefaultText(
//                   text: translate(AppStrings.save),
//                   textColor: AppColors.primary,
//                   onTap: () {
//                     NavigationService.pop();
//                   },
//                 ),
//               ),
//             ],
//           ),
//           widget.extras.isEmpty
//               ? SizedBox(
//                   height: 50.h,
//                   child: Center(
//                     child: DefaultText(
//                       text: translate(AppStrings.noExtras),
//                     ),
//                   ),
//                 )
//               : SizedBox(
//                   height: 50.h,
//                   child: ListView.builder(
//                     padding: EdgeInsets.all(5.w),
//                     itemCount: widget.extras.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         width: 90.w,
//                         height: 8.h,
//                         margin: EdgeInsets.symmetric(
//                           vertical: 0.5.h,
//                         ),
//                         padding: EdgeInsets.symmetric(
//                           vertical: 0.5.h,
//                           horizontal: 3.w,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.shade.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 DefaultText(
//                                   text: isArabic
//                                       ? widget.extras[index].nameAr ?? ""
//                                       : widget.extras[index].nameEn ?? "",
//                                   textColor: AppColors.white,
//                                   fontSize: 12.sp,
//                                 ),
//                                 DefaultText(
//                                   text:
//                                       "${widget.extras[index].price ?? ""} ${translate(AppStrings.currency)}",
//                                   textColor: AppColors.white,
//                                   fontSize: 10.sp,
//                                 ),
//                               ],
//                             ),
//                             Checkbox(
//                               value:
//                                   selectedExtra.contains(widget.extras[index])
//                                       ? true
//                                       : isChecked[index],
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               onChanged: (value) {
//                                 isChecked[index] = value!;
//                                 isChecked[index]
//                                     ? {
//                                         selectedExtra.add(widget.extras[index]),
//                                         extrasIds.add(widget.extras[index].id!),
//                                         extrasPrice = extrasPrice +
//                                             widget.extras[index].price!,
//                                       }
//                                     : {
//                                         selectedExtra
//                                             .remove(widget.extras[index]),
//                                         extrasIds
//                                             .remove(widget.extras[index].id!),
//                                         extrasPrice = extrasPrice -
//                                             widget.extras[index].price!,
//                                       };
//                                 setState(() {
//                                   printResponse(extrasPrice.toString());
//                                 });
//                               },
//                               activeColor: AppColors.primary,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
