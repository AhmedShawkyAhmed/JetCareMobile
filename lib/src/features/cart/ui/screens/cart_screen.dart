import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/cart/cubit/cart_cubit.dart';
import 'package:jetcare/src/features/cart/ui/widgets/cart_item.dart';
import 'package:jetcare/src/features/shared/ui/views/body_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartCubit cubit = BlocProvider.of(context);

  @override
  void initState() {
    cubit.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is GetCartLoading) {
                return SizedBox(
                  width: 25.w,
                  height: 25.w,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return cubit.cart == null || cubit.cart!.isEmpty
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
                                    " ${cubit.total} ${translate(AppStrings.currency)}",
                              ),
                            ],
                          ),
                        ),
                        DefaultAppButton(
                          title: translate(AppStrings.con),
                          fontSize: 14.sp,
                          onTap: () {
                            NavigationService.pushNamed(
                              Routes.appointment,
                              arguments: AppRouterArgument(
                                total: cubit.total.toString(),
                              ),
                            );
                          },
                          textColor: AppColors.primary,
                          buttonColor: AppColors.white,
                        ),
                        ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.cart?.length ?? 0,
                          itemBuilder: (context, index) {
                            return CartItem(
                              withDelete: true,
                              image: cubit.cart![index].package == null
                                  ? cubit.cart![index].item?.image ??
                                      "1674441185.jpg"
                                  : cubit.cart![index].package!.image!,
                              name: cubit.cart![index].package == null
                                  ? isArabic
                                      ? cubit.cart![index].item?.nameAr ?? ""
                                      : cubit.cart![index].item?.nameEn ?? ""
                                  : isArabic
                                      ? cubit.cart![index].package!.nameAr!
                                      : cubit.cart![index].package!.nameEn!,
                              count: cubit.cart![index].count.toString(),
                              price: cubit.cart![index].price.toString(),
                              onDelete: () {
                                cubit.deleteFromCart(
                                    cartItem: cubit.cart![index]);
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
    );
  }
}
