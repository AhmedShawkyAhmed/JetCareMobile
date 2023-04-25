import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatelessWidget {
  final AppRouterArgument appRouterArgument;

  const OTPScreen({
    required this.appRouterArgument,
    Key? key,
  }) : super(key: key);

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
                  activeColor: AppColors.pc,
                  selectedColor: AppColors.pc,
                  selectedFillColor: AppColors.pc,
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
              textColor: AppColors.pc2,
              onTap: () {
                // TODO: resend code
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            DefaultAppButton(
              title: translate(AppStrings.verify),
              onTap: () async {
                // TODO: verify
                if (verifyCodeController.text != "") {
                  IndicatorView.showIndicator(context);
                                Navigator.pop(context);

                      if (appRouterArgument.type == "resetPassword") {
                        Navigator.pushNamed(
                          context,
                          AppRouterNames.resetPassword,
                          arguments: AppRouterArgument(
                            phone: appRouterArgument.phone.toString(),
                            type: "resetPassword",
                          ),
                        );
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouterNames.profile,
                          (route) => false,
                          arguments: AppRouterArgument(
                            type: "register",
                            phone: appRouterArgument.phone.toString(),
                          ),
                        );
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
