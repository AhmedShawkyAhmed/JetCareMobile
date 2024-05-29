import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/home/views/card_view.dart';
import 'package:jetcare/src/presentation/views/cart_item.dart';
import 'package:jetcare/src/features/shared/views/loading_view.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool myOrder = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(instance())..getMyOrders(),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          hasBack: false,
          widget: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DefaultText(
                    text: translate(AppStrings.myOrders),
                    onTap: () {
                      setState(() {
                        myOrder = true;
                      });
                    },
                    textColor: myOrder ? AppColors.white : AppColors.silver,
                  ),
                  DefaultText(
                    text: translate(AppStrings.corporate),
                    onTap: () {
                      setState(() {
                        myOrder = false;
                      });
                    },
                    textColor: myOrder ? AppColors.silver : AppColors.white,
                  ),
                ],
              ),
              myOrder
                  ? BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        if (OrderCubit(instance()).historyResponse?.orders ==
                            null) {
                          return LoadingView(
                            width: 90.w,
                            height: 15.h,
                          );
                        }
                        return OrderCubit(instance())
                                .historyResponse!
                                .orders!
                                .isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                      left: 3.w, right: 3.w, top: 2.h),
                                  itemCount: OrderCubit(instance())
                                      .historyResponse!
                                      .orders!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        NavigationService.pushNamed(
                                          Routes.confirmOrder,
                                          // todo add order
                                          // arguments: AppRouterArgument(
                                          //   orderModel: OrderCubit(instance())
                                          //       .historyResponse!
                                          //       .orders![index],
                                          // ),
                                        );
                                      },
                                      child: CartItem(
                                        withDelete: false,
                                        onDelete: () {},
                                        name:
                                            "# ${OrderCubit(instance()).historyResponse!.orders![index].id.toString()}",
                                        count: OrderCubit(instance())
                                            .historyResponse!
                                            .orders![index]
                                            .date
                                            .toString(),
                                        price: OrderCubit(instance())
                                            .historyResponse!
                                            .orders![index]
                                            .total
                                            .toString(),
                                        image: "1674441185.jpg",
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(top: 40.h),
                                child: DefaultText(
                                    text: translate(AppStrings.noOrders)),
                              );
                      },
                    )
                  : BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        if (OrderCubit(instance())
                                .historyResponse
                                ?.corporates ==
                            null) {
                          return LoadingView(
                            width: 90.w,
                            height: 15.h,
                          );
                        }
                        return OrderCubit(instance())
                                .historyResponse!
                                .corporates!
                                .isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  padding:
                                      EdgeInsets.only(left: 3.w, right: 3.w),
                                  itemCount: OrderCubit(instance())
                                      .historyResponse!
                                      .corporates!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return CardView(
                                      title: isArabic
                                          ? OrderCubit(instance())
                                              .historyResponse!
                                              .corporates![index]
                                              .item!
                                              .nameAr
                                          : OrderCubit(instance())
                                              .historyResponse!
                                              .corporates![index]
                                              .item!
                                              .nameEn,
                                      image: OrderCubit(instance())
                                          .historyResponse!
                                          .corporates![index]
                                          .item!
                                          .image,
                                      height: 15.h,
                                      mainHeight: 20.h,
                                      titleFont: 17.sp,
                                      colorMain:
                                          AppColors.primary.withOpacity(0.8),
                                      colorSub:
                                          AppColors.shade.withOpacity(0.4),
                                      onTap: () {
                                        NavigationService.pushNamed(
                                          Routes.orderDetails,
                                          arguments: AppRouterArgument(
                                            type: "corporate",
                                            corporateModel:
                                                OrderCubit(instance())
                                                    .historyResponse!
                                                    .corporates![index],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(top: 40.h),
                                child: DefaultText(
                                  text: translate(AppStrings.noOrders),
                                ),
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
