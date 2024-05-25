import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/arguments/otp_arguments.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatelessWidget {
  final OtpArguments arguments;

  const OTPScreen({
    required this.arguments,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController verifyCodeController = TextEditingController();
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
              text: arguments.email,
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
                AuthCubit(instance()).verifyEmail(
                  email: arguments.email,
                  type: OTPTypes.resend,
                );
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            DefaultAppButton(
              title: translate(AppStrings.verify),
              onTap: () async {
                AuthCubit(instance()).validateCode(
                  type: arguments.type,
                  email: arguments.email,
                  code: verifyCodeController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
