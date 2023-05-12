import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/cart_cubit/cart_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/cart_item.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()
        ..getMyCart(userId: globalAccountModel.id!, afterSuccess: () {}),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          hasBack: false,
          widget: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (CartCubit.get(context).cartResponse?.total == null) {
                  return SizedBox(
                    width: 25.w,
                    height: 25.w,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return CartCubit.get(context).cartResponse!.status != 200
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
                                      " ${CartCubit.get(context).cartResponse?.total.toString() ?? 0} ${translate(AppStrings.currency)}",
                                ),
                              ],
                            ),
                          ),
                          DefaultAppButton(
                            title: translate(AppStrings.con),
                            fontSize: 14.sp,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRouterNames.appointment);
                            },
                            textColor: AppColors.pc,
                            buttonColor: AppColors.white,
                          ),
                          ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: CartCubit.get(context)
                                    .cartResponse
                                    ?.cart
                                    ?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return CartItem(
                                withDelete: true,
                                image: CartCubit.get(context)
                                            .cartResponse!
                                            .cart![index]
                                            .package ==
                                        null
                                    ? CartCubit.get(context)
                                            .cartResponse!
                                            .cart![index]
                                            .item
                                            ?.image ??
                                        "1674441185.jpg"
                                    : CartCubit.get(context)
                                        .cartResponse!
                                        .cart![index]
                                        .package!
                                        .image!,
                                name: CartCubit.get(context)
                                            .cartResponse!
                                            .cart![index]
                                            .package ==
                                        null
                                    ? CartCubit.get(context)
                                            .cartResponse!
                                            .cart![index]
                                            .item
                                            ?.nameEn ??
                                        ""
                                    : CartCubit.get(context)
                                        .cartResponse!
                                        .cart![index]
                                        .package!
                                        .nameEn!,
                                count: CartCubit.get(context)
                                    .cartResponse!
                                    .cart![index]
                                    .count
                                    .toString(),
                                price: CartCubit.get(context)
                                    .cartResponse!
                                    .cart![index]
                                    .price
                                    .toString(),
                                onDelete: () {
                                  IndicatorView.showIndicator(context);
                                  CartCubit.get(context).deleteFromCart(
                                    id: CartCubit.get(context)
                                        .cartResponse!
                                        .cart![index]
                                        .id,
                                    afterSuccess: () {
                                      setState(() {
                                        CartCubit.get(context)
                                            .cartResponse!
                                            .total = (CartCubit.get(context)
                                                .cartResponse!
                                                .total!
                                                .toInt() -
                                            CartCubit.get(context)
                                                .cartResponse!
                                                .cart![index]
                                                .price
                                                .toInt());
                                      });
                                      CartCubit.get(context)
                                          .cartResponse!
                                          .cart!
                                          .removeAt(index);
                                      Navigator.pop(context);
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
