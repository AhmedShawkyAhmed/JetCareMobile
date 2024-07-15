import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/arguments/order_arguments.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/cart/ui/widgets/cart_item.dart';
import 'package:jetcare/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final OrderArguments arguments;

  const ConfirmOrderScreen({
    required this.arguments,
    super.key,
  });

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
   TextEditingController reasonController = TextEditingController();

   @override
  void dispose() {
     reasonController.dispose();
    super.dispose();
  }
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
                          " ${widget.arguments.order.price ?? 0} ${translate(AppStrings.currency)}",
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
                      text: widget.arguments.order.shipping == 0
                          ? translate(AppStrings.free)
                          : " ${widget.arguments.order.shipping ?? 0} ${translate(AppStrings.currency)}",
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
                          " ${widget.arguments.order.total ?? 0} ${translate(AppStrings.currency)}",
                    ),
                  ],
                ),
              ),
              if (widget.arguments.order.status ==
                  OrderStatus.unassigned.name) ...[
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
                                OrdersCubit(instance()).cancelOrder(
                                  orderId: widget.arguments.order.id!,
                                  reason: reasonController.text,
                                );
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
                itemCount: widget.arguments.order.cart!.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    withDelete: false,
                    image: widget.arguments.order.cart![index].package == null
                        ? widget.arguments.order.cart![index].item!.image!
                        : widget.arguments.order.cart![index].package!.image!,
                    name: widget.arguments.order.cart![index].package == null
                        ? isArabic
                            ? widget.arguments.order.cart![index].item!.nameAr!
                            : widget.arguments.order.cart![index].item!.nameEn!
                        : isArabic
                            ? widget
                                .arguments.order.cart![index].package!.nameAr!
                            : widget
                                .arguments.order.cart![index].package!.nameEn!,
                    count: widget.arguments.order.cart![index].count.toString(),
                    price: widget.arguments.order.cart![index].price.toString(),
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
