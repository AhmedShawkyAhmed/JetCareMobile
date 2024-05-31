import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/routing/arguments/task_arguments.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/crew/cubit/crew_cubit.dart';
import 'package:jetcare/src/features/crew/data/requests/update_order_status_request.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/cart/ui/widgets/cart_item.dart';
import 'package:sizer/sizer.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskArguments arguments;

  const TaskDetailsScreen({
    required this.arguments,
    super.key,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late CrewCubit cubit = BlocProvider.of(context);
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
              if (widget.arguments.order.status == OrderStatus.assigned.name)
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
                            cubit.rejectOrder(
                              orderId: widget.arguments.order.id!,
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
                            cubit.updateOrderStatus(
                              request: UpdateOrderStatusRequest(
                                id: widget.arguments.order.id!,
                                status: OrderStatus.accepted.name,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              if (widget.arguments.order.status == OrderStatus.accepted.name)
                DefaultAppButton(
                  title: translate(AppStrings.complete),
                  onTap: () {
                    cubit.updateOrderStatus(
                      request: UpdateOrderStatusRequest(
                        id: widget.arguments.order.id!,
                        status: OrderStatus.completed.name,
                      ),
                    );
                  },
                ),
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
