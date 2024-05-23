import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/app_cubit/app_cubit.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/services/notification_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/cart_item.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:sizer/sizer.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const ConfirmOrderScreen({
    required this.appRouterArgument,
    super.key,
  });

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: true,
        widget: Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    DefaultText(
                      text: translate(AppStrings.price),
                    ),
                    const Spacer(),
                    DefaultText(
                      text:
                          " ${widget.appRouterArgument.orderModel!.price ?? 0} ${translate(AppStrings.currency)}",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    DefaultText(
                      text: translate(AppStrings.shipping),
                    ),
                    const Spacer(),
                    DefaultText(
                      text: widget.appRouterArgument.orderModel!.shipping == 0
                          ? translate(AppStrings.free)
                          : " ${widget.appRouterArgument.orderModel!.shipping ?? 0} ${translate(AppStrings.currency)}",
                    ),
                  ],
                ),
              ),
              Divider(
                endIndent: 10.w,
                indent: 10.w,
                color: AppColors.primary,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    DefaultText(
                      text: translate(AppStrings.total),
                    ),
                    const Spacer(),
                    DefaultText(
                      text:
                          " ${widget.appRouterArgument.orderModel!.total ?? 0} ${translate(AppStrings.currency)}",
                    ),
                  ],
                ),
              ),
              if (globalAccountModel.role == "crew" &&
                  widget.appRouterArgument.orderModel!.status == "assigned")
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
                            IndicatorView.showIndicator(context);
                            OrderCubit(instance()).rejectOrder(
                              orderId: widget.appRouterArgument.orderModel!.id!,
                              afterSuccess: () {
                                NavigationService.pushNamedAndRemoveUntil(
                                  AppRouterNames.crewLayout,
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
                            IndicatorView.showIndicator(context);
                            OrderCubit(instance()).updateOrderStatus(
                              orderId: widget.appRouterArgument.orderModel!.id!,
                              status: "accepted",
                              afterSuccess: () {
                                setState(() {
                                  widget.appRouterArgument.orderModel!.status ==
                                      "accepted";
                                });
                                NavigationService.pushNamedAndRemoveUntil(
                                  AppRouterNames.crewLayout,
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
              if (globalAccountModel.role == "crew" &&
                  widget.appRouterArgument.orderModel!.status == "accepted")
                DefaultAppButton(
                  title: translate(AppStrings.complete),
                  onTap: () {
                    IndicatorView.showIndicator(context);
                    OrderCubit(instance()).updateOrderStatus(
                      orderId: widget.appRouterArgument.orderModel!.id!,
                      status: "completed",
                      afterSuccess: () {
                        OrderCubit(instance()).getMyTasks();
                        NavigationService.pushNamedAndRemoveUntil(
                          AppRouterNames.crewLayout,
                          (route) => false,
                        );
                      },
                      afterCancel: () {},
                    );
                  },
                ),
              if (globalAccountModel.role != "crew" &&
                  widget.appRouterArgument.orderModel!.status ==
                      "unassigned") ...[
                DefaultAppButton(
                  title: translate(AppStrings.cancel),
                  fontSize: 14.sp,
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.mainColor,
                          title: DefaultText(
                            text: translate(AppStrings.cancelOrder),
                            align: TextAlign.center,
                            fontSize: 19.sp,
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                DefaultText(
                                  text: translate(AppStrings.cancelOrderQ),
                                  align: TextAlign.center,
                                  fontSize: 15.sp,
                                  maxLines: 3,
                                ),
                                DefaultTextField(
                                  controller: reasonController,
                                  marginVertical: 0,
                                  marginHorizontal: 0,
                                  hintText: translate(AppStrings.cancelReason),
                                  maxLine: 10,
                                  height: 15.h,
                                  width: 100.w,
                                  maxLength: 500,
                                ),
                              ],
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: <Widget>[
                            DefaultText(
                              text: translate(AppStrings.cancelOrder),
                              align: TextAlign.center,
                              fontSize: 13.sp,
                              textColor: AppColors.darkRed,
                              onTap: () {
                                if (reasonController.text == "") {
                                  DefaultToast.showMyToast(
                                      translate(AppStrings.enterCancelReason));
                                } else {
                                  IndicatorView.showIndicator(context);
                                  OrderCubit(instance()).updateOrderStatusUser(
                                      orderId: widget
                                          .appRouterArgument.orderModel!.id!,
                                      status: "canceled",
                                      reason: reasonController.text,
                                      afterSuccess: () {
                                        AppCubit().changeIndex(0);
                                        NavigationService.pushReplacementNamed(
                                            AppRouterNames.layout);
                                        NotificationCubit(instance())
                                            .saveNotification(
                                          title: "الطلبات",
                                          message: "تم إلغاء طلبك بنجاح",
                                          afterSuccess: () {
                                            NotificationService()
                                                .showNotification(
                                              id: 12,
                                              title: "الطلبات",
                                              body: "تم إلغاء طلبك بنجاح",
                                            );
                                          },
                                        );
                                      },
                                      afterCancel: () {
                                        reasonController.clear();
                                        NavigationService.pop();
                                        NavigationService.pop();
                                      });
                                }
                              },
                            ),
                            DefaultText(
                              text: translate(AppStrings.cancel),
                              align: TextAlign.center,
                              fontSize: 13.sp,
                              onTap: () {
                                NavigationService.pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  textColor: AppColors.white,
                  buttonColor: AppColors.darkRed,
                ),
              ],
              SizedBox(
                height: 1.h,
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.appRouterArgument.orderModel!.cart!.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    withDelete: false,
                    image: widget.appRouterArgument.orderModel!.cart![index]
                                .package ==
                            null
                        ? widget.appRouterArgument.orderModel!.cart![index]
                            .item!.image!
                        : widget.appRouterArgument.orderModel!.cart![index]
                            .package!.image!,
                    name: widget.appRouterArgument.orderModel!.cart![index]
                                .package ==
                            null
                        ? CacheService.get(
                                    key: CacheKeys.language) ==
                                "ar"
                            ? widget.appRouterArgument.orderModel!.cart![index]
                                .item!.nameAr!
                            : widget.appRouterArgument.orderModel!.cart![index]
                                .item!.nameEn!
                        : CacheService.get(
                                    key: CacheKeys.language) ==
                                "ar"
                            ? widget.appRouterArgument.orderModel!.cart![index]
                                .package!.nameAr!
                            : widget.appRouterArgument.orderModel!.cart![index]
                                .package!.nameEn!,
                    count: widget
                        .appRouterArgument.orderModel!.cart![index].count
                        .toString(),
                    price: widget
                        .appRouterArgument.orderModel!.cart![index].price
                        .toString(),
                    onDelete: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
