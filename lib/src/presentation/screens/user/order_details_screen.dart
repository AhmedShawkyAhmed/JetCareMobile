import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/views/home_view.dart';
import 'package:jetcare/src/presentation/views/summery_item.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class OrderDetailsScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const OrderDetailsScreen({
    required this.appRouterArgument,
    Key? key,
  }) : super(key: key);

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
          padding: EdgeInsets.only(left: 5.w, right: 5.w,top: 5.h),
          child: widget.appRouterArgument.type == "package" ||
                  widget.appRouterArgument.type == "item"
              ? ListView(
                  children: [
                    widget.appRouterArgument.type == "package"
                        ? CardView(
                            image: widget
                                .appRouterArgument.orderModel!.package!.image,
                            title: CacheHelper.getDataFromSharedPreference(
                                        key: SharedPreferenceKeys.language) ==
                                    "ar"
                                ? widget.appRouterArgument.orderModel!.package!
                                    .nameAr
                                : widget.appRouterArgument.orderModel!.package!
                                    .nameEn,
                            colorMain: AppColors.pc.withOpacity(0.8),
                            colorSub: AppColors.shade.withOpacity(0.4),
                            height: 19.h,
                            mainHeight: 25.h,
                            titleFont: 17.sp,
                            onTap: () {},
                          )
                        : CardView(
                            image: widget
                                .appRouterArgument.orderModel!.item!.image,
                            title: CacheHelper.getDataFromSharedPreference(
                                        key: SharedPreferenceKeys.language) ==
                                    "ar"
                                ? widget
                                    .appRouterArgument.orderModel!.item!.nameAr
                                : widget
                                    .appRouterArgument.orderModel!.item!.nameEn,
                            colorMain: AppColors.pc.withOpacity(0.8),
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
                            text: CacheHelper.getDataFromSharedPreference(
                                        key: SharedPreferenceKeys.language) ==
                                    "ar"
                                ? "${widget.appRouterArgument.orderModel!.package!.descriptionAr}"
                                : "${widget.appRouterArgument.orderModel!.package!.descriptionEn}",
                            maxLines: 50,
                            fontSize: 15.sp,
                          )
                        : DefaultText(
                            text: CacheHelper.getDataFromSharedPreference(
                                        key: SharedPreferenceKeys.language) ==
                                    "ar"
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
                          "${widget.appRouterArgument.orderModel!.address!.floor},"
                          " ${widget.appRouterArgument.orderModel!.address!.building},"
                          " ${widget.appRouterArgument.orderModel!.address!.street},"
                          " ${widget.appRouterArgument.orderModel!.address!.area},"
                          " ${widget.appRouterArgument.orderModel!.address!.district}",
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
                      type: "details",
                      paddingWidth: 0.w,
                      visible: widget
                          .appRouterArgument.orderModel!.extras!.isNotEmpty,
                      itemList: widget.appRouterArgument.orderModel!.extras,
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
                    if (globalAccountModel.role == "crew" &&
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
                                  OrderCubit.get(context).rejectOrder(
                                    orderId: widget
                                        .appRouterArgument.orderModel!.id!,
                                    afterSuccess: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRouterNames.crewLayout,
                                        (route) => false,
                                      );
                                      OrderCubit.get(context).getMyTasks();
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
                                  OrderCubit.get(context).updateOrderStatus(
                                    orderId: widget
                                        .appRouterArgument.orderModel!.id!,
                                    status: "accepted",
                                    afterSuccess: () {
                                      setState(() {
                                        widget.appRouterArgument.orderModel!
                                                .status ==
                                            "accepted";
                                      });
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRouterNames.crewLayout,
                                        (route) => false,
                                      );
                                      OrderCubit.get(context).getMyTasks();
                                    },
                                    afterCancel: (){},
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (globalAccountModel.role == "crew" &&
                        widget.appRouterArgument.orderModel!.status ==
                            "accepted")
                      DefaultAppButton(
                        title: translate(AppStrings.complete),
                        onTap: () {
                          OrderCubit.get(context).updateOrderStatus(
                            orderId: widget.appRouterArgument.orderModel!.id!,
                            status: "completed",
                            afterSuccess: () {
                              OrderCubit.get(context).getMyTasks();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRouterNames.crewLayout,
                                (route) => false,
                              );
                            },
                            afterCancel: (){},
                          );
                        },
                      ),
                    if (globalAccountModel.role == "client" &&
                        widget.appRouterArgument.orderModel?.crew == null)
                      DefaultAppButton(
                        title: translate(AppStrings.cancel),
                        buttonColor: AppColors.darkRed,
                        onTap: () {
                          OrderCubit.get(context).updateOrderStatus(
                            orderId: widget.appRouterArgument.orderModel!.id!,
                            status: "canceled",
                            afterSuccess: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRouterNames.layout,
                                (route) => false,
                              );
                              DefaultToast.showMyToast(
                                  translate(AppStrings.cancelOrder));
                              OrderCubit.get(context).getMyOrders();
                            },
                            afterCancel: (){},
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
                      image: widget
                          .appRouterArgument.corporateModel!.item!.image,
                      title: CacheHelper.getDataFromSharedPreference(
                                  key: SharedPreferenceKeys.language) ==
                              "ar"
                          ? widget
                              .appRouterArgument.corporateModel!.item!.nameAr
                          : widget
                              .appRouterArgument.corporateModel!.item!.nameEn,
                      colorMain: AppColors.pc.withOpacity(0.8),
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
                      text: CacheHelper.getDataFromSharedPreference(
                                  key: SharedPreferenceKeys.language) ==
                              "ar"
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
