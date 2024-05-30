import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
import 'package:jetcare/src/features/cart/ui/widgets/cart_item.dart';
import 'package:jetcare/src/features/notifications/cubit/notification_cubit.dart';
import 'package:jetcare/src/features/notifications/data/requests/notification_request.dart';
import 'package:jetcare/src/features/shared/ui/views/body_view.dart';
import 'package:jetcare/src/features/shared/ui/views/indicator_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text_field.dart';
import 'package:jetcare/src/features/shared/ui/widgets/toast.dart';
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
              if (Globals.userData.role != "crew" &&
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
                                  IndicatorView.showIndicator();
                                  OrderCubit(instance()).updateOrderStatusUser(
                                      orderId: widget
                                          .appRouterArgument.orderModel!.id!,
                                      status: OrderStatus.canceled.name,
                                      reason: reasonController.text,
                                      afterSuccess: () {
                                        NavigationService.pushReplacementNamed(
                                          Routes.layout,
                                          arguments: 0,
                                        );
                                        NotificationCubit(instance())
                                            .saveNotification(
                                          request: NotificationRequest(
                                            userId: Globals.userData.id!,
                                            title: "الطلبات",
                                            message: "تم إلغاء طلبك بنجاح",
                                          ),
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
                        ? isArabic
                            ? widget.appRouterArgument.orderModel!.cart![index]
                                .item!.nameAr!
                            : widget.appRouterArgument.orderModel!.cart![index]
                                .item!.nameEn!
                        : isArabic
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
