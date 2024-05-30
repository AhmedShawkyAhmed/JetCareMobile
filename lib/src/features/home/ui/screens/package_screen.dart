import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/cart/cubit/cart_cubit.dart';
import 'package:jetcare/src/features/cart/data/requests/cart_request.dart';
import 'package:jetcare/src/features/home/data/models/package_details_model.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:jetcare/src/features/home/ui/widgets/package_item.dart';
import 'package:jetcare/src/features/shared/ui/views/body_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class PackageScreen extends StatefulWidget {
  final PackageDetailsModel packageDetails;

  const PackageScreen({
    required this.packageDetails,
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
          widget: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CardView(
                  title: isArabic
                      ? widget.packageDetails.package!.nameAr
                      : widget.packageDetails.package!.nameEn,
                  image: widget.packageDetails.package!.image,
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
                  itemCount: widget.packageDetails.items!.length,
                  itemBuilder: (context, index) {
                    return PackageItem(
                      title: isArabic
                          ? widget.packageDetails.items![index].nameAr!
                          : widget.packageDetails.items![index].nameEn!,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              const Spacer(),
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
                              "${((widget.packageDetails.package!.price)!.toInt() * (quantity == 0 ? 1 : quantity))} ${translate(AppStrings.currency)}",
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
                            packageId: widget.packageDetails.package!.id!,
                            count: quantity,
                            price: (widget.packageDetails.package!.price)!
                                .toDouble(),
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
      ),
    );
  }
}
