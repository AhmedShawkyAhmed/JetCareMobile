import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/NotificationDownloadingService.dart';
import 'package:jetcare/src/business_logic/app_cubit/app_cubit.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/cart_item.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  ConfirmOrderScreen({
    required this.appRouterArgument,
    Key? key,
  }) : super(key: key);

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
                            OrderCubit.get(context).rejectOrder(
                              orderId: widget.appRouterArgument.orderModel!.id!,
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
                              orderId: widget.appRouterArgument.orderModel!.id!,
                              status: "accepted",
                              afterSuccess: () {
                                setState(() {
                                  widget.appRouterArgument.orderModel!.status ==
                                      "accepted";
                                });
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRouterNames.crewLayout,
                                  (route) => false,
                                );
                                OrderCubit.get(context).getMyTasks();
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
                                  OrderCubit.get(context).updateOrderStatusUser(
                                      orderId: widget
                                          .appRouterArgument.orderModel!.id!,
                                      status: "canceled",
                                      reason: reasonController.text,
                                      afterSuccess: () {
                                        AppCubit.get(context).changeIndex(0);
                                        Navigator.pushReplacementNamed(
                                            context, AppRouterNames.layout);
                                        NotificationCubit.get(context)
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
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      });
                                }
                              },
                            ),
                            DefaultText(
                              text: translate(AppStrings.cancel),
                              align: TextAlign.center,
                              fontSize: 13.sp,
                              onTap: () {
                                Navigator.pop(context);
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
                        ? CacheHelper.getDataFromSharedPreference(
                                    key: SharedPreferenceKeys.language) ==
                                "ar"
                            ? widget.appRouterArgument.orderModel!.cart![index]
                                .item!.nameAr!
                            : widget.appRouterArgument.orderModel!.cart![index]
                                .item!.nameEn!
                        : CacheHelper.getDataFromSharedPreference(
                                    key: SharedPreferenceKeys.language) ==
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
