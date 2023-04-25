import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/views/loading_view.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CrewHistoryScreen extends StatelessWidget {
  const CrewHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        child: const Center(
          child: Icon(
            Icons.refresh_outlined,
            color: AppColors.pc,
          ),
        ),
        onPressed: () {
          OrderCubit.get(context).getMyTasks();
        },
      ),
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
              return OrderCubit.get(context)
                      .tasksResponse!
                      .ordersHistory!
                      .isNotEmpty
                  ? Container(
                      height: 80.h,
                      width: 90.w,
                      margin: EdgeInsets.only(top: 3.h),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: OrderCubit.get(context)
                            .tasksResponse!
                            .ordersHistory!
                            .length,
                        itemBuilder: (context, index) {
                          return CardView(
                            title: CacheHelper.getDataFromSharedPreference(
                                        key: SharedPreferenceKeys.language) ==
                                    "ar"
                                ? OrderCubit.get(context)
                                            .tasksResponse!
                                            .ordersHistory![index]
                                            .package ==
                                        null
                                    ? OrderCubit.get(context)
                                            .tasksResponse!
                                            .ordersHistory![index]
                                            .item
                                            ?.nameAr ??
                                        ""
                                    : OrderCubit.get(context)
                                            .tasksResponse!
                                            .ordersHistory![index]
                                            .package
                                            ?.nameAr ??
                                        ""
                                : OrderCubit.get(context)
                                            .tasksResponse!
                                            .ordersHistory![index]
                                            .package ==
                                        null
                                    ? OrderCubit.get(context)
                                            .tasksResponse!
                                            .ordersHistory![index]
                                            .item
                                            ?.nameEn ??
                                        ""
                                    : OrderCubit.get(context)
                                            .tasksResponse!
                                            .ordersHistory![index]
                                            .package
                                            ?.nameEn ??
                                        "",
                            image: OrderCubit.get(context)
                                        .tasksResponse!
                                        .ordersHistory![index]
                                        .package ==
                                    null
                                ? OrderCubit.get(context)
                                    .tasksResponse!
                                    .ordersHistory![index]
                                    .item!
                                    .image
                                : OrderCubit.get(context)
                                    .tasksResponse!
                                    .ordersHistory![index]
                                    .package!
                                    .image,
                            colorMain: AppColors.pc.withOpacity(0.8),
                            colorSub: AppColors.shade.withOpacity(0.4),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouterNames.orderDetails,
                                arguments: AppRouterArgument(
                                  type: OrderCubit.get(context)
                                              .tasksResponse!
                                              .ordersHistory![index]
                                              .package ==
                                          null
                                      ? "item"
                                      : "package",
                                  orderModel: OrderCubit.get(context)
                                      .tasksResponse!
                                      .ordersHistory![index],
                                ),
                              );
                            },
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
    );
  }
}
