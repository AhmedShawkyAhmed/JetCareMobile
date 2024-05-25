import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/cart_cubit/cart_cubit.dart';
import 'package:jetcare/src/business_logic/details_cubit/details_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/features/shared/views/indicator_view.dart';
import 'package:jetcare/src/presentation/views/package_item_widget.dart';
import 'package:sizer/sizer.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({
    super.key,
  });

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          hasBack: true,
          widget: ListView(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CardView(
                  title: isArabic
                      ? DetailsCubit(instance())
                          .packageResponse!
                          .packageModel!
                          .nameAr
                      : DetailsCubit(instance())
                          .packageResponse!
                          .packageModel!
                          .nameEn,
                  image: DetailsCubit(instance())
                      .packageResponse!
                      .packageModel!
                      .image,
                  height: 19.h,
                  mainHeight: 25.h,
                  titleFont: 15.sp,
                  colorMain: AppColors.primary.withOpacity(0.8),
                  colorSub: AppColors.shade.withOpacity(0.4),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  shrinkWrap: true,
                  itemCount:
                      DetailsCubit(instance()).packageResponse!.items!.length,
                  itemBuilder: (context, index) {
                    return PackageItem(
                      title: isArabic
                          ? DetailsCubit(instance())
                              .packageResponse!
                              .items![index]
                              .nameAr!
                          : DetailsCubit(instance())
                              .packageResponse!
                              .items![index]
                              .nameEn!,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: DefaultText(
                      text: "${translate(AppStrings.enterSpace)} M²",
                      fontSize: 12.sp,
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
                              "${((DetailsCubit(instance()).packageResponse!.packageModel!.price)!.toInt() * (quantity == 0 ? 1 : quantity))} ${translate(AppStrings.currency)}",
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
                        if (quantity == 0) {
                          DefaultToast.showMyToast(
                              translate(AppStrings.enterQuantity));
                        } else {
                          IndicatorView.showIndicator();
                          CartCubit(instance()).addToCart(
                            packageId: DetailsCubit(instance())
                                .packageResponse!
                                .packageModel!
                                .id!,
                            count: quantity,
                            price: (DetailsCubit(instance())
                                    .packageResponse!
                                    .packageModel!
                                    .price)!
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
      ),
    );
  }
}
