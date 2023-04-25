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

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool myOrder = true;

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
          OrderCubit.get(context).getMyOrders();
        },
      ),
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
                      if (OrderCubit.get(context).historyResponse?.orders ==
                          null) {
                        return LoadingView(
                          width: 90.w,
                          height: 15.h,
                        );
                      }
                      return OrderCubit.get(context)
                              .historyResponse!
                              .orders!
                              .isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                itemCount: OrderCubit.get(context)
                                    .historyResponse!
                                    .orders!
                                    .length,
                                itemBuilder: (context, index) {
                                  return CardView(
                                    title:
                                        CacheHelper.getDataFromSharedPreference(
                                                    key: SharedPreferenceKeys
                                                        .language) ==
                                                "ar"
                                            ? OrderCubit.get(context)
                                                        .historyResponse!
                                                        .orders![index]
                                                        .package ==
                                                    null
                                                ? OrderCubit.get(context)
                                                        .historyResponse!
                                                        .orders![index]
                                                        .item
                                                        ?.nameAr ??
                                                    ""
                                                : OrderCubit.get(context)
                                                        .historyResponse!
                                                        .orders![index]
                                                        .package
                                                        ?.nameAr ??
                                                    ""
                                            : OrderCubit.get(context)
                                                        .historyResponse!
                                                        .orders![index]
                                                        .package ==
                                                    null
                                                ? OrderCubit.get(context)
                                                        .historyResponse!
                                                        .orders![index]
                                                        .item
                                                        ?.nameEn ??
                                                    ""
                                                : OrderCubit.get(context)
                                                        .historyResponse!
                                                        .orders![index]
                                                        .package
                                                        ?.nameEn ??
                                                    "",
                                    image: OrderCubit.get(context)
                                                .historyResponse!
                                                .orders![index]
                                                .package ==
                                            null
                                        ? OrderCubit.get(context)
                                            .historyResponse!
                                            .orders![index]
                                            .item!
                                            .image
                                        : OrderCubit.get(context)
                                            .historyResponse!
                                            .orders![index]
                                            .package!
                                            .image,
                                    colorMain: AppColors.pc.withOpacity(0.8),
                                    colorSub: AppColors.shade.withOpacity(0.4),
                                    status: true,
                                    statusColor: OrderCubit.get(context)
                                                .historyResponse!
                                                .orders![index]
                                                .status ==
                                            "unassigned"
                                        ? AppColors.silver
                                        : OrderCubit.get(context)
                                                    .historyResponse!
                                                    .orders![index]
                                                    .status ==
                                                "assigned"
                                            ? AppColors.orange
                                            : OrderCubit.get(context)
                                                        .historyResponse!
                                                        .orders![index]
                                                        .status ==
                                                    "accepted"
                                                ? AppColors.darkBlue
                                                : AppColors.transparent,
                                    height: 15.h,
                                    mainHeight: 20.h,
                                    titleFont: 17.sp,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRouterNames.orderDetails,
                                        arguments: AppRouterArgument(
                                          type: OrderCubit.get(context)
                                                      .historyResponse!
                                                      .orders![index]
                                                      .package ==
                                                  null
                                              ? "item"
                                              : "package",
                                          orderModel: OrderCubit.get(context)
                                              .historyResponse!
                                              .orders![index],
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
                                  text: translate(AppStrings.noOrders)),
                            );
                    },
                  )
                : BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (OrderCubit.get(context).historyResponse?.corporates ==
                          null) {
                        return LoadingView(
                          width: 90.w,
                          height: 15.h,
                        );
                      }
                      return OrderCubit.get(context)
                              .historyResponse!
                              .corporates!
                              .isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                itemCount: OrderCubit.get(context)
                                    .historyResponse!
                                    .corporates!
                                    .length,
                                itemBuilder: (context, index) {
                                  return CardView(
                                    title:
                                        CacheHelper.getDataFromSharedPreference(
                                                    key: SharedPreferenceKeys
                                                        .language) ==
                                                "ar"
                                            ? OrderCubit.get(context)
                                                .historyResponse!
                                                .corporates![index]
                                                .item!
                                                .nameAr
                                            : OrderCubit.get(context)
                                                .historyResponse!
                                                .corporates![index]
                                                .item!
                                                .nameEn,
                                    image: OrderCubit.get(context)
                                        .historyResponse!
                                        .corporates![index]
                                        .item!
                                        .image,
                                    height: 15.h,
                                    mainHeight: 20.h,
                                    titleFont: 17.sp,
                                    colorMain: AppColors.pc.withOpacity(0.8),
                                    colorSub: AppColors.shade.withOpacity(0.4),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRouterNames.orderDetails,
                                        arguments: AppRouterArgument(
                                          type: "corporate",
                                          corporateModel:
                                              OrderCubit.get(context)
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
    );
  }
}
