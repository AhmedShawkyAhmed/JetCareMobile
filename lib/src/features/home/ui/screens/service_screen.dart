import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/cache_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/arguments/home_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/cart/cubit/cart_cubit.dart';
import 'package:jetcare/src/features/cart/data/requests/cart_request.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class ServiceScreen extends StatefulWidget {
  final HomeArguments arguments;

  const ServiceScreen({
    required this.arguments,
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
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: CardView(
                        title: isArabic
                            ? widget.arguments.item!.nameAr
                            : widget.arguments.item!.nameEn,
                        image: widget.arguments.item!.image,
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
                              ? widget.arguments.item!.descriptionAr!
                              : widget.arguments.item!.descriptionEn!,
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
                            text: "${widget.arguments.item!.unit}",
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
                                    "${((widget.arguments.item!.price)!.toInt() * (quantity == 0 ? 1 : quantity))} ${translate(AppStrings.currency)}",
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CacheService.get(key: CacheKeys.token) == null
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
                              CartCubit(instance()).addToCart(
                                request: CartRequest(
                                  userId: Globals.userData.id!,
                                  itemId: widget.arguments.item!.id,
                                  count: quantity,
                                  price:
                                      widget.arguments.item!.price!.toDouble(),
                                ),
                              );
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
