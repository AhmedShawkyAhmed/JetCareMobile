import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/cart_item.dart';
import 'package:jetcare/src/presentation/views/loading_view.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CrewHomeScreen extends StatelessWidget {
  const CrewHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..getMyTasks(),
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
                if (OrderCubit.get(context).tasksResponse == null) {
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
                return OrderCubit.get(context).tasksResponse!.orders!.isNotEmpty
                    ? Container(
                        height: 80.h,
                        width: 90.w,
                        margin: EdgeInsets.only(top: 3.h),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: OrderCubit.get(context)
                              .tasksResponse!
                              .orders!
                              .length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.pushNamed(
                                  context,
                                  AppRouterNames.confirmOrder,
                                  arguments: AppRouterArgument(
                                    orderModel: OrderCubit.get(context)
                                        .tasksResponse!
                                        .orders![index],
                                  ),
                                );
                              },
                              child: CartItem(
                                withDelete: false,
                                onDelete: () {},
                                name:
                                "# ${OrderCubit.get(context).tasksResponse!.orders![index].id.toString()}",
                                count: OrderCubit.get(context)
                                    .tasksResponse!
                                    .orders![index]
                                    .date
                                    .toString(),
                                price: OrderCubit.get(context)
                                    .tasksResponse!
                                    .orders![index]
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
