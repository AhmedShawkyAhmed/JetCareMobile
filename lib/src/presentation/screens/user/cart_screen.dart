import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/cart_cubit/cart_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/cart_item.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(instance())
        ..getMyCart(userId: globalAccountModel.id!, afterSuccess: () {}),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          hasBack: false,
          widget: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (CartCubit(instance()).cartResponse?.total == null) {
                  return SizedBox(
                    width: 25.w,
                    height: 25.w,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return CartCubit(instance()).cartResponse!.status != 200
                    ? const Center(
                        child: DefaultText(
                          text: "لا يوجد عناصر",
                        ),
                      )
                    : ListView(
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
                                      " ${CartCubit(instance()).cartResponse?.total.toString() ?? 0} ${translate(AppStrings.currency)}",
                                ),
                              ],
                            ),
                          ),
                          DefaultAppButton(
                            title: translate(AppStrings.con),
                            fontSize: 14.sp,
                            onTap: () {
                              NavigationService.pushNamed(Routes.appointment,
                                  arguments: AppRouterArgument(
                                      total: CartCubit(instance())
                                          .cartResponse
                                          ?.total
                                          .toString()));
                            },
                            textColor: AppColors.primary,
                            buttonColor: AppColors.white,
                          ),
                          ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: CartCubit(instance())
                                    .cartResponse
                                    ?.cart
                                    ?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return CartItem(
                                withDelete: true,
                                image: CartCubit(instance())
                                            .cartResponse!
                                            .cart![index]
                                            .package ==
                                        null
                                    ? CartCubit(instance())
                                            .cartResponse!
                                            .cart![index]
                                            .item
                                            ?.image ??
                                        "1674441185.jpg"
                                    : CartCubit(instance())
                                        .cartResponse!
                                        .cart![index]
                                        .package!
                                        .image!,
                                name: CartCubit(instance())
                                            .cartResponse!
                                            .cart![index]
                                            .package ==
                                        null
                                    ? isArabic
                                        ? CartCubit(instance())
                                                .cartResponse!
                                                .cart![index]
                                                .item
                                                ?.nameAr ??
                                            ""
                                        : CartCubit(instance())
                                                .cartResponse!
                                                .cart![index]
                                                .item
                                                ?.nameEn ??
                                            ""
                                    : isArabic
                                        ? CartCubit(instance())
                                            .cartResponse!
                                            .cart![index]
                                            .package!
                                            .nameAr!
                                        : CartCubit(instance())
                                            .cartResponse!
                                            .cart![index]
                                            .package!
                                            .nameEn!,
                                count: CartCubit(instance())
                                    .cartResponse!
                                    .cart![index]
                                    .count
                                    .toString(),
                                price: CartCubit(instance())
                                    .cartResponse!
                                    .cart![index]
                                    .price
                                    .toString(),
                                onDelete: () {
                                  IndicatorView.showIndicator();
                                  CartCubit(instance()).deleteFromCart(
                                    id: CartCubit(instance())
                                        .cartResponse!
                                        .cart![index]
                                        .id,
                                    afterSuccess: () {
                                      setState(() {
                                        CartCubit(instance())
                                            .cartResponse!
                                            .total = (CartCubit(instance())
                                                .cartResponse!
                                                .total!
                                                .toInt() -
                                            CartCubit(instance())
                                                .cartResponse!
                                                .cart![index]
                                                .price
                                                .toInt());
                                        cart.removeAt(index);
                                      });
                                      CartCubit(instance())
                                          .cartResponse!
                                          .cart!
                                          .removeAt(index);
                                      NavigationService.pop();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
