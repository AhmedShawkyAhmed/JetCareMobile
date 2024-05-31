// import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:intl/intl.dart';
// import 'package:jetcare/src/core/constants/app_colors.dart';
// import 'package:jetcare/src/core/constants/app_strings.dart';
// import 'package:jetcare/src/core/di/service_locator.dart';
// import 'package:jetcare/src/core/routing/arguments/order_arguments.dart';
// import 'package:jetcare/src/core/utils/enums.dart';
// import 'package:jetcare/src/core/utils/shared_methods.dart';
// import 'package:jetcare/src/features/home/ui/views/card_view.dart';
// import 'package:jetcare/src/features/home/ui/views/home_view.dart';
// import 'package:jetcare/src/features/orders/cubit/orders_cubit.dart';
// import 'package:jetcare/src/features/orders/ui/views/summery_item.dart';
// import 'package:jetcare/src/features/shared/views/body_view.dart';
// import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
// import 'package:jetcare/src/features/shared/widgets/default_text.dart';
// import 'package:sizer/sizer.dart';
//
// class OrderDetailsScreen extends StatefulWidget {
//   final OrderArguments arguments;
//
//   const OrderDetailsScreen({
//     required this.arguments,
//     super.key,
//   });
//
//   @override
//   State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
// }
//
// class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       body: BodyView(
//         hasBack: true,
//         widget: Padding(
//           padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
//           child: ListView(
//             children: [
//               widget.arguments.type == "package"
//                   ? CardView(
//                 image: widget.arguments.order.package!.image,
//                 title: isArabic
//                     ? widget.arguments.order.package!.nameAr
//                     : widget.arguments.order.package!.nameEn,
//                 colorMain: AppColors.primary.withOpacity(0.8),
//                 colorSub: AppColors.shade.withOpacity(0.4),
//                 height: 19.h,
//                 mainHeight: 25.h,
//                 titleFont: 17.sp,
//                 onTap: () {},
//               )
//                   : CardView(
//                 image: widget.arguments.order.item!.image,
//                 title: isArabic
//                     ? widget.arguments.order.item!.nameAr
//                     : widget.arguments.order.item!.nameEn,
//                 colorMain: AppColors.primary.withOpacity(0.8),
//                 colorSub: AppColors.shade.withOpacity(0.4),
//                 height: 19.h,
//                 mainHeight: 25.h,
//                 titleFont: 17.sp,
//                 onTap: () {},
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: 3.h,
//                 ),
//                 child: DefaultText(
//                   text: translate(AppStrings.description),
//                 ),
//               ),
//               widget.arguments.type == "package"
//                   ? DefaultText(
//                 text: isArabic
//                     ? "${widget.arguments.order.package!.descriptionAr}"
//                     : "${widget.arguments.order.package!.descriptionEn}",
//                 maxLines: 50,
//                 fontSize: 15.sp,
//               )
//                   : DefaultText(
//                 text: isArabic
//                     ? "${widget.arguments.order.item!.descriptionAr}"
//                     : "${widget.arguments.order.item!.descriptionEn}",
//                 maxLines: 50,
//                 fontSize: 15.sp,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
//                 child: DefaultText(
//                   text: translate(AppStrings.orderDetails),
//                 ),
//               ),
//               SummeryItem(
//                 visible: true,
//                 title: translate(AppStrings.orderPhone),
//                 sub: "${widget.arguments.order.address!.phone}",
//                 padding: 0,
//               ),
//               SummeryItem(
//                 visible: true,
//                 title: translate(AppStrings.orderAddress),
//                 sub: "${widget.arguments.order.address!.address},"
//                     " ${widget.arguments.order.address!.area!.nameAr},"
//                     " ${widget.arguments.order.address!.state!.nameAr}",
//                 padding: 0,
//               ),
//               SummeryItem(
//                 visible: true,
//                 title: translate(AppStrings.orderDate),
//                 sub: "${widget.arguments.order.date}",
//                 padding: 0,
//               ),
//               SummeryItem(
//                 visible: true,
//                 title: translate(AppStrings.orderDay),
//                 sub: DateFormat('EEEE').format(
//                     DateTime.parse(widget.arguments.order.date.toString())),
//                 padding: 0,
//               ),
//               SummeryItem(
//                 visible: true,
//                 title: translate(AppStrings.orderTime),
//                 sub:
//                 "${widget.arguments.order.period!.from} - ${widget.arguments
//                     .order.period!.to}",
//                 padding: 0,
//               ),
//               SummeryItem(
//                 visible: true,
//                 title: translate(AppStrings.orderCrew),
//                 sub: widget.arguments.order.crew?.name ?? "*************",
//                 padding: 0,
//               ),
//               SummeryItem(
//                 visible: true,
//                 title: translate(AppStrings.orderCrewPhone),
//                 sub: widget.arguments.order.crew?.phone ?? "*************",
//                 padding: 0,
//               ),
//               SummeryItem(
//                 visible: true,
//                 title: translate(AppStrings.total),
//                 sub:
//                 "${widget.arguments.order.total} ${translate(
//                     AppStrings.currency)}",
//                 padding: 0,
//               ),
//               HomeView(
//                 title: translate(AppStrings.extras),
//                 type: HomeViewType.details,
//                 paddingWidth: 0.w,
//                 visible: widget.arguments.order.extras!.isNotEmpty,
//                 itemList: widget.arguments.order.extras,
//               ),
//               if (widget.arguments.order.comment != "")
//                 Padding(
//                   padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
//                   child: DefaultText(
//                     text: translate(AppStrings.comment),
//                   ),
//                 ),
//               if (widget.arguments.order.comment != "")
//                 DefaultText(
//                   text: "${widget.arguments.order.comment}",
//                   maxLines: 50,
//                   fontSize: 15.sp,
//                 ),
//               if (widget.arguments.order.crew == null)
//                 DefaultAppButton(
//                   title: translate(AppStrings.cancel),
//                   buttonColor: AppColors.darkRed,
//                   onTap: ()
//                     OrdersCubit(instance()).cancelOrder(
//                         orderId: widget.arguments.order.id!,
//                         reason:
//                     );
//                   },
//                 ),
//               SizedBox(
//                 height: 2.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
