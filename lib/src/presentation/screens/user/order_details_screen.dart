import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';
import 'package:jetcare/src/features/home/views/card_view.dart';
import 'package:jetcare/src/features/home/views/home_view.dart';
import 'package:jetcare/src/presentation/views/summery_item.dart';
import 'package:sizer/sizer.dart';

class OrderDetailsScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const OrderDetailsScreen({
    required this.appRouterArgument,
    super.key,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: true,
        widget: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
          child: widget.appRouterArgument.type == "package" ||
                  widget.appRouterArgument.type == "item"
              ? ListView(
                  children: [
                    widget.appRouterArgument.type == "package"
                        ? CardView(
                            image: widget
                                .appRouterArgument.orderModel!.package!.image,
                            title: isArabic
                                ? widget.appRouterArgument.orderModel!.package!
                                    .nameAr
                                : widget.appRouterArgument.orderModel!.package!
                                    .nameEn,
                            colorMain: AppColors.primary.withOpacity(0.8),
                            colorSub: AppColors.shade.withOpacity(0.4),
                            height: 19.h,
                            mainHeight: 25.h,
                            titleFont: 17.sp,
                            onTap: () {},
                          )
                        : CardView(
                            image: widget
                                .appRouterArgument.orderModel!.item!.image,
                            title: isArabic
                                ? widget
                                    .appRouterArgument.orderModel!.item!.nameAr
                                : widget
                                    .appRouterArgument.orderModel!.item!.nameEn,
                            colorMain: AppColors.primary.withOpacity(0.8),
                            colorSub: AppColors.shade.withOpacity(0.4),
                            height: 19.h,
                            mainHeight: 25.h,
                            titleFont: 17.sp,
                            onTap: () {},
                          ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 3.h,
                      ),
                      child: DefaultText(
                        text: translate(AppStrings.description),
                      ),
                    ),
                    widget.appRouterArgument.type == "package"
                        ? DefaultText(
                            text: isArabic
                                ? "${widget.appRouterArgument.orderModel!.package!.descriptionAr}"
                                : "${widget.appRouterArgument.orderModel!.package!.descriptionEn}",
                            maxLines: 50,
                            fontSize: 15.sp,
                          )
                        : DefaultText(
                            text: isArabic
                                ? "${widget.appRouterArgument.orderModel!.item!.descriptionAr}"
                                : "${widget.appRouterArgument.orderModel!.item!.descriptionEn}",
                            maxLines: 50,
                            fontSize: 15.sp,
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
                      child: DefaultText(
                        text: translate(AppStrings.orderDetails),
                      ),
                    ),
                    SummeryItem(
                      visible: true,
                      title: translate(AppStrings.orderPhone),
                      sub:
                          "${widget.appRouterArgument.orderModel!.address!.phone}",
                      padding: 0,
                    ),
                    SummeryItem(
                      visible: true,
                      title: translate(AppStrings.orderAddress),
                      sub:
                          "${widget.appRouterArgument.orderModel!.address!.address},"
                          " ${widget.appRouterArgument.orderModel!.address!.area!.nameAr},"
                          " ${widget.appRouterArgument.orderModel!.address!.state!.nameAr}",
                      padding: 0,
                    ),
                    SummeryItem(
                      visible: true,
                      title: translate(AppStrings.orderDate),
                      sub: "${widget.appRouterArgument.orderModel?.date}",
                      padding: 0,
                    ),
                    SummeryItem(
                      visible: true,
                      title: translate(AppStrings.orderDay),
                      sub: DateFormat('EEEE').format(DateTime.parse(widget
                          .appRouterArgument.orderModel!.date
                          .toString())),
                      padding: 0,
                    ),
                    SummeryItem(
                      visible: true,
                      title: translate(AppStrings.orderTime),
                      sub:
                          "${widget.appRouterArgument.orderModel!.period!.from} - ${widget.appRouterArgument.orderModel!.period!.to}",
                      padding: 0,
                    ),
                    SummeryItem(
                      visible: true,
                      title: translate(AppStrings.orderCrew),
                      sub: widget.appRouterArgument.orderModel?.crew?.name ??
                          "*************",
                      padding: 0,
                    ),
                    SummeryItem(
                      visible: true,
                      title: translate(AppStrings.orderCrewPhone),
                      sub: widget.appRouterArgument.orderModel?.crew?.phone ??
                          "*************",
                      padding: 0,
                    ),
                    SummeryItem(
                      visible: true,
                      title: translate(AppStrings.total),
                      sub:
                          "${widget.appRouterArgument.orderModel!.total} ${translate(AppStrings.currency)}",
                      padding: 0,
                    ),
                    HomeView(
                      title: translate(AppStrings.extras),
                      type: HomeViewType.details,
                      paddingWidth: 0.w,
                      visible: widget
                          .appRouterArgument.orderModel!.extras!.isNotEmpty,
                      // todo add items
                      // itemList: widget.appRouterArgument.orderModel!.extras,
                    ),
                    if (widget.appRouterArgument.orderModel?.comment != "")
                      Padding(
                        padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                        child: DefaultText(
                          text: translate(AppStrings.comment),
                        ),
                      ),
                    if (widget.appRouterArgument.orderModel?.comment != "")
                      DefaultText(
                        text: "${widget.appRouterArgument.orderModel!.comment}",
                        maxLines: 50,
                        fontSize: 15.sp,
                      ),
                    if (Globals.userData.role == "crew" &&
                        widget.appRouterArgument.orderModel!.status ==
                            "assigned")
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DefaultAppButton(
                                title: translate(AppStrings.reject),
                                width: 30.w,
                                height: 4.h,
                                radius: 5.sp,
                                marginHorizontal: 0,
                                buttonColor: AppColors.darkRed,
                                onTap: () {
                                  OrderCubit(instance()).rejectOrder(
                                    orderId: widget
                                        .appRouterArgument.orderModel!.id!,
                                    afterSuccess: () {
                                      NavigationService.pushNamedAndRemoveUntil(
                                        Routes.crewLayout,
                                        (route) => false,
                                      );
                                      OrderCubit(instance()).getMyTasks();
                                    },
                                  );
                                },
                              ),
                              DefaultAppButton(
                                title: translate(AppStrings.accept),
                                width: 30.w,
                                height: 4.h,
                                radius: 5.sp,
                                marginHorizontal: 0,
                                buttonColor: AppColors.darkBlue,
                                onTap: () {
                                  OrderCubit(instance()).updateOrderStatusUser(
                                    orderId: widget
                                        .appRouterArgument.orderModel!.id!,
                                    status: "accepted",
                                    afterSuccess: () {
                                      setState(() {
                                        widget.appRouterArgument.orderModel!
                                                .status ==
                                            "accepted";
                                      });
                                      NavigationService.pushNamedAndRemoveUntil(
                                        Routes.crewLayout,
                                        (route) => false,
                                      );
                                      OrderCubit(instance()).getMyTasks();
                                    },
                                    afterCancel: () {},
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (Globals.userData.role == "crew" &&
                        widget.appRouterArgument.orderModel!.status ==
                            "accepted")
                      DefaultAppButton(
                        title: translate(AppStrings.complete),
                        onTap: () {
                          OrderCubit(instance()).updateOrderStatusUser(
                            orderId: widget.appRouterArgument.orderModel!.id!,
                            status: "completed",
                            afterSuccess: () {
                              OrderCubit(instance()).getMyTasks();
                              NavigationService.pushNamedAndRemoveUntil(
                                Routes.crewLayout,
                                (route) => false,
                              );
                            },
                            afterCancel: () {},
                          );
                        },
                      ),
                    if (Globals.userData.role == "client" &&
                        widget.appRouterArgument.orderModel?.crew == null)
                      DefaultAppButton(
                        title: translate(AppStrings.cancel),
                        buttonColor: AppColors.darkRed,
                        onTap: () {
                          OrderCubit(instance()).updateOrderStatusUser(
                            orderId: widget.appRouterArgument.orderModel!.id!,
                            status: "canceled",
                            afterSuccess: () {
                              NavigationService.pushNamedAndRemoveUntil(
                                Routes.layout,
                                (route) => false,
                              );
                              DefaultToast.showMyToast(
                                  translate(AppStrings.cancelOrder));
                              OrderCubit(instance()).getMyOrders();
                            },
                            afterCancel: () {},
                          );
                        },
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                )
              : ListView(
                  children: [
                    CardView(
                      image:
                          widget.appRouterArgument.corporateModel!.item!.image,
                      title: isArabic
                          ? widget
                              .appRouterArgument.corporateModel!.item!.nameAr
                          : widget
                              .appRouterArgument.corporateModel!.item!.nameEn,
                      colorMain: AppColors.primary.withOpacity(0.8),
                      colorSub: AppColors.shade.withOpacity(0.4),
                      height: 19.h,
                      mainHeight: 25.h,
                      titleFont: 17.sp,
                      onTap: () {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                      child: DefaultText(
                        text: translate(AppStrings.description),
                      ),
                    ),
                    DefaultText(
                      text: isArabic
                          ? "${widget.appRouterArgument.corporateModel!.item!.descriptionAr}"
                          : "${widget.appRouterArgument.corporateModel!.item!.descriptionEn}",
                      maxLines: 50,
                      fontSize: 15.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                      child: DefaultText(
                        text: translate(AppStrings.corporateName),
                      ),
                    ),
                    DefaultText(
                      text: "${widget.appRouterArgument.corporateModel!.name}",
                      maxLines: 50,
                      fontSize: 15.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                      child: DefaultText(
                        text: translate(AppStrings.email),
                      ),
                    ),
                    DefaultText(
                      text: "${widget.appRouterArgument.corporateModel!.email}",
                      maxLines: 50,
                      fontSize: 15.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                      child: DefaultText(
                        text: translate(AppStrings.phone),
                      ),
                    ),
                    DefaultText(
                      text: "${widget.appRouterArgument.corporateModel!.phone}",
                      maxLines: 50,
                      fontSize: 15.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
                      child: DefaultText(
                        text: translate(AppStrings.message),
                      ),
                    ),
                    DefaultText(
                      text:
                          "${widget.appRouterArgument.corporateModel!.message}",
                      maxLines: 50,
                      fontSize: 15.sp,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
