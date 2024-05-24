import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/cart_cubit/cart_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:sizer/sizer.dart';

class ServiceScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const ServiceScreen({
    required this.appRouterArgument,
    super.key,
  });

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool edit = false;
  int quantity = 0;
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          hasBack: true,
          widget: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
                      child: CardView(
                        title: isArabic
                            ? widget.appRouterArgument.itemModel!.nameAr
                            : widget.appRouterArgument.itemModel!.nameEn,
                        image: widget.appRouterArgument.itemModel!.image,
                        height: 19.h,
                        mainHeight: 25.h,
                        titleFont: 15.sp,
                        colorMain: AppColors.primary.withOpacity(0.8),
                        colorSub: AppColors.shade.withOpacity(0.4),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: DefaultText(
                        text: translate(AppStrings.description),
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: DefaultText(
                          maxLines: 17,
                          text: isArabic
                              ? widget.appRouterArgument.itemModel!.descriptionAr!
                              : widget
                                  .appRouterArgument.itemModel!.descriptionEn!,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: DefaultText(
                            text: "${widget.appRouterArgument.itemModel!.unit}",
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultTextField(
                            width: 25.w,
                            marginVertical: 0,
                            marginHorizontal: 5.w,
                            maxLength: 5,
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            hintText: "",
                            onChange: (value) {
                              setState(() {
                                printError(value);
                                quantity = int.parse(value == "" ? "0" : value);
                              });
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: SizedBox(
                              width: 50.w,
                              child: DefaultText(
                                align: TextAlign.end,
                                text:
                                "${((widget.appRouterArgument.itemModel!.price)!.toInt() * (quantity == 0?1:quantity))} ${translate(AppStrings.currency)}",
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CacheService.get(
                                key: CacheKeys.password) ==
                            null
                        ? DefaultAppButton(
                            title: translate(AppStrings.loginFirst),
                            onTap: () {
                              NavigationService.pushNamedAndRemoveUntil(

                                Routes.login,
                                (route) => false,
                              );
                            },
                          )
                        : DefaultAppButton(
                            title: translate(AppStrings.toCart),
                            onTap: () {
                              if(quantity == 0){
                                DefaultToast.showMyToast(translate(AppStrings.enterQuantity));
                              }else{
                                IndicatorView.showIndicator();
                                CartCubit(instance()).addToCart(
                                  itemId: widget.appRouterArgument.itemModel!.id,
                                  count: quantity,
                                  price: widget.appRouterArgument.itemModel!.price!
                                      .toDouble(),
                                  afterSuccess: () {
                                    quantityController.clear();
                                    NavigationService.pushNamedAndRemoveUntil(

                                      Routes.addedToCart,
                                          (route) => false,
                                    );
                                  },
                                );
                              }
                            },
                          ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
