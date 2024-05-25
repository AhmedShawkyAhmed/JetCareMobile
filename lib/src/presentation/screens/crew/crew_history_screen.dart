import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/cart_item.dart';
import 'package:jetcare/src/presentation/views/loading_view.dart';
import 'package:sizer/sizer.dart';

class CrewHistoryScreen extends StatelessWidget {
  const CrewHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => OrderCubit(instance())..getMyTasks(),
  child: Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Padding(
          padding: EdgeInsets.only(
            top: 4.h,
            left: 3.w,
            right: 3.w,
            bottom: 4.h,
          ),
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (OrderCubit(instance()).tasksResponse == null) {
                return Container(
                  height: 80.h,
                  width: 90.w,
                  margin: EdgeInsets.only(top: 3.h),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return LoadingView(
                        width: 90.w,
                        height: 15.h,
                      );
                    },
                  ),
                );
              }
              return OrderCubit(instance())
                      .tasksResponse!
                      .ordersHistory!
                      .isNotEmpty
                  ? Container(
                      height: 80.h,
                      width: 90.w,
                      margin: EdgeInsets.only(top: 3.h),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: OrderCubit(instance())
                            .tasksResponse!
                            .ordersHistory!
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              NavigationService.pushNamed(

                                Routes.confirmOrder,
                                arguments: AppRouterArgument(
                                  orderModel: OrderCubit(instance())
                                      .tasksResponse!
                                      .ordersHistory![index],
                                ),
                              );
                            },
                            child: CartItem(
                              withDelete: false,
                              onDelete: () {},
                              name:
                              "# ${OrderCubit(instance()).tasksResponse!.ordersHistory![index].id.toString()}",
                              count: OrderCubit(instance())
                                  .tasksResponse!
                                  .ordersHistory![index]
                                  .date
                                  .toString(),
                              price: OrderCubit(instance())
                                  .tasksResponse!
                                  .ordersHistory![index]
                                  .total
                                  .toString(),
                              image: "1674441185.jpg",
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: DefaultText(
                        text: translate(AppStrings.noTasks),
                      ),
                    );
            },
          ),
        ),
      ),
    ),
);
  }
}
