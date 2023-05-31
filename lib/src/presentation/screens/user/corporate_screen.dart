import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/network/requests/corporate_request.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class CorporateScreen extends StatelessWidget {
  final AppRouterArgument appRouterArgument;

  CorporateScreen({
    required this.appRouterArgument,
    Key? key,
  }) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h),
              child: CardView(
                title: CacheHelper.getDataFromSharedPreference(
                            key: SharedPreferenceKeys.language) ==
                        "ar"
                    ? appRouterArgument.itemModel!.nameAr
                    : appRouterArgument.itemModel!.nameEn,
                image: appRouterArgument.itemModel!.image!,
                height: 19.h,
                mainHeight: 25.h,
                titleFont: 15.sp,
                colorMain: AppColors.pc.withOpacity(0.8),
                colorSub: AppColors.shade.withOpacity(0.4),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 1.h,
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
            if (appRouterArgument.itemModel!.descriptionAr != "" &&
                appRouterArgument.itemModel!.descriptionAr != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: DefaultText(
                  text: CacheHelper.getDataFromSharedPreference(
                              key: SharedPreferenceKeys.language) ==
                          "ar"
                      ? appRouterArgument.itemModel!.descriptionAr.toString()
                      : appRouterArgument.itemModel!.descriptionEn.toString(),
                  fontSize: 12.sp,
                  maxLines: 200,
                  align: TextAlign.start,
                ),
              ),
            SizedBox(
              height: 2.h,
            ),
            DefaultTextField(
              controller: nameController,
              hintText: translate(AppStrings.corporateName),
            ),
            DefaultTextField(
              controller: emailController,
              hintText: translate(AppStrings.email),
            ),
            DefaultTextField(
              controller: phoneController,
              hintText: translate(AppStrings.phone),
            ),
            DefaultTextField(
              controller: messageController,
              hintText: translate(AppStrings.message),
              maxLine: 10,
              height: 25.h,
              maxLength: 500,
            ),
            DefaultAppButton(
                title: translate(AppStrings.send),
                onTap: () {
                  if (nameController.text == "") {
                    DefaultToast.showMyToast(translate(AppStrings.enterName));
                  } else if (emailController.text == "") {
                    DefaultToast.showMyToast(translate(AppStrings.enterEmail));
                  } else if (phoneController.text == "") {
                    DefaultToast.showMyToast(translate(AppStrings.enterPhone));
                  } else if (messageController.text == "") {
                    DefaultToast.showMyToast(
                        translate(AppStrings.enterMessage));
                  } else {
                    OrderCubit.get(context).corporateOrder(
                      corporateRequest: CorporateRequest(
                        userId: globalAccountModel.id!,
                        itemId: appRouterArgument.itemModel!.id!,
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        message: messageController.text,
                      ),
                      afterSuccess: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouterNames.success,
                          arguments: AppRouterArgument(
                            type: "order",
                          ),
                          (route) => false,
                        );
                      },
                    );
                  }
                }),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
