import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatelessWidget {
  final AppRouterArgument appRouterArgument;

  const OTPScreen({
    required this.appRouterArgument,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultText(
              text: translate(AppStrings.codeSent),
              fontSize: 18.sp,
            ),
            SizedBox(
              height: 1.h,
            ),
            DefaultText(
              text: appRouterArgument.phone.toString(),
              fontSize: 15.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: true,
                keyboardType: TextInputType.phone,
                animationType: AnimationType.none,
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.darkGrey,
                ),
                obscuringCharacter: '#',
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  fieldHeight: 13.w,
                  fieldWidth: 13.w,
                  activeColor: AppColors.primary,
                  selectedColor: AppColors.primary,
                  selectedFillColor: AppColors.primary,
                  inactiveColor: AppColors.lightGrey,
                  errorBorderColor: AppColors.red,
                  inactiveFillColor: AppColors.lightGrey,
                  activeFillColor: AppColors.lightGrey,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: AppColors.transparent,
                enableActiveFill: true,
                controller: verifyCodeController,
                onCompleted: (v) {
                  verifyCodeController.clear();
                  verifyCodeController.text = v;
                  printResponse(verifyCodeController.text);
                },
                onChanged: (value) {
                  printResponse(value.toString());
                },
              ),
            ),
            DefaultText(
              text: translate(AppStrings.resend),
              fontSize: 13.sp,
              textColor: AppColors.primaryLight,
              onTap: () {
                IndicatorView.showIndicator(context);
                AuthCubit(instance()).sendEmail(
                  email: appRouterArgument.phone.toString(),
                  success: () {
                    NavigationService.pop();
                    DefaultToast.showMyToast(
                      "تم إرسال كود التحقق",
                    );
                  },
                  failed: () {
                    NavigationService.pop();
                    DefaultToast.showMyToast(
                      translate(AppStrings.error),
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            DefaultAppButton(
              title: translate(AppStrings.verify),
              onTap: () async {
                if (verifyCodeController.text != "") {
                  if (verifyCodeController.text == verifyCode.toString()) {
                    IndicatorView.showIndicator(context);
                    if (appRouterArgument.type == "resetPassword") {
                      NavigationService.pushNamed(

                        AppRouterNames.resetPassword,
                        arguments: AppRouterArgument(
                          phone: appRouterArgument.phone.toString(),
                          type: "resetPassword",
                        ),
                      );
                    } else {
                      NavigationService.pushNamed(

                        AppRouterNames.profile,
                        arguments: AppRouterArgument(
                          type: "register",
                          phone: appRouterArgument.phone.toString(),
                        ),
                      );
                    }
                  } else {
                    DefaultToast.showMyToast("كود التحقق خطأ");
                  }
                } else {
                  DefaultToast.showMyToast(translate(AppStrings.enterCode));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
