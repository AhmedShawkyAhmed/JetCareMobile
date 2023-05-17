import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/cart_cubit/cart_cubit.dart';
import 'package:jetcare/src/business_logic/details_cubit/details_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/views/package_item_widget.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: CacheHelper.getDataFromSharedPreference(
                            key: SharedPreferenceKeys.language) ==
                        "ar"
                    ? DetailsCubit.get(context)
                        .packageResponse!
                        .packageModel!
                        .nameAr
                    : DetailsCubit.get(context)
                        .packageResponse!
                        .packageModel!
                        .nameEn,
                image: DetailsCubit.get(context)
                    .packageResponse!
                    .packageModel!
                    .image,
                height: 19.h,
                mainHeight: 25.h,
                titleFont: 17.sp,
                colorMain: AppColors.pc.withOpacity(0.8),
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
                    DetailsCubit.get(context).packageResponse!.items!.length,
                itemBuilder: (context, index) {
                  return PackageItem(
                    title: CacheHelper.getDataFromSharedPreference(
                                key: SharedPreferenceKeys.language) ==
                            "ar"
                        ? DetailsCubit.get(context)
                            .packageResponse!
                            .items![index]
                            .nameAr!
                        : DetailsCubit.get(context)
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
                    hintText: translate(AppStrings.orderSpace),
                    onChange: (value) {
                      setState(() {
                        printError(value);
                        quantity = int.parse(value == "" ? "1" : value);
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
                            "${((DetailsCubit.get(context).packageResponse!.packageModel!.price)!.toInt() * quantity)} ${translate(AppStrings.currency)}",
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CacheHelper.getDataFromSharedPreference(
                        key: SharedPreferenceKeys.password) ==
                    null
                ? DefaultAppButton(
                    title: translate(AppStrings.loginFirst),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouterNames.login,
                        (route) => false,
                      );
                    },
                  )
                : DefaultAppButton(
                    title: translate(AppStrings.toCart),
                    onTap: () {
                      IndicatorView.showIndicator(context);
                      CartCubit.get(context).addToCart(
                        packageId: DetailsCubit.get(context)
                            .packageResponse!
                            .packageModel!
                            .id!,
                        count: quantity,
                        price: (DetailsCubit.get(context)
                                .packageResponse!
                                .packageModel!
                                .price)!
                            .toDouble(),
                        afterSuccess: () {
                          quantityController.clear();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouterNames.addedToCart,
                            (route) => false,
                          );
                        },
                      );
                    },
                  ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
