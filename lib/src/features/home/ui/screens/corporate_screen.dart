import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/arguments/home_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/network/requests/corporate_request.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:jetcare/src/features/shared/ui/views/body_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text_field.dart';
import 'package:jetcare/src/features/shared/ui/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class CorporateScreen extends StatelessWidget {
  final HomeArguments arguments;

  CorporateScreen({
    required this.arguments,
    super.key,
  });

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
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: CardView(
                title:
                    isArabic ? arguments.item!.nameAr : arguments.item!.nameEn,
                image: arguments.item!.image!,
                height: 19.h,
                mainHeight: 25.h,
                titleFont: 15.sp,
                colorMain: AppColors.primary.withOpacity(0.8),
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
            if (arguments.item!.descriptionAr != "" &&
                arguments.item!.descriptionAr != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: DefaultText(
                  text: isArabic
                      ? arguments.item!.descriptionAr.toString()
                      : arguments.item!.descriptionEn.toString(),
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
                    OrderCubit(instance()).corporateOrder(
                      corporateRequest: CorporateRequest(
                        userId: Globals.userData.id!,
                        itemId: arguments.item!.id!,
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        message: messageController.text,
                      ),
                      afterSuccess: () {
                        NavigationService.pushNamedAndRemoveUntil(
                          Routes.success,
                          arguments: SuccessType.order,
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
