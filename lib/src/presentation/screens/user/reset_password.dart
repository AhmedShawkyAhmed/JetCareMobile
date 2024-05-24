import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const ResetPassword({
    required this.appRouterArgument,
    super.key,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool password = true;
  bool confirm = true;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: ListView(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
          children: [
            SizedBox(
              height: 5.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 11.w),
              width: 50.w,
              height: 15.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/translogow.png"),
                ),
              ),
            ),
            DefaultTextField(
              controller: passwordController,
              hintText: translate(AppStrings.password),
              password: password,
              suffix: InkWell(
                onTap: () {
                  setState(() {
                    password = !password;
                  });
                },
                child: Icon(
                  password ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ),
            DefaultTextField(
              controller: confirmPasswordController,
              hintText: translate(AppStrings.conPass),
              password: confirm,
              suffix: InkWell(
                onTap: () {
                  setState(() {
                    confirm = !confirm;
                  });
                },
                child: Icon(
                  confirm ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            DefaultAppButton(
              title: translate(AppStrings.reset),
              onTap: () {
                if (passwordController.text != confirmPasswordController.text) {
                  DefaultToast.showMyToast(
                      translate(AppStrings.passwordMatched));
                } else {
                  IndicatorView.showIndicator();
                  NavigationService.pop();
                  AuthCubit(instance()).resetPassword(
                    authRequest: LoginRequest(
                      email: widget.appRouterArgument.phone.toString(),
                      password: passwordController.text,
                    ),
                    afterSuccess: () {
                      NavigationService.pushNamedAndRemoveUntil(
                        Routes.login,
                        (route) => false,
                      );
                    },
                  );
                }
              },
            ),
            DefaultAppButton(
              title: translate(AppStrings.cancel),
              buttonColor: AppColors.darkRed,
              onTap: () {
                NavigationService.pushNamedAndRemoveUntil(
                  Routes.login,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
