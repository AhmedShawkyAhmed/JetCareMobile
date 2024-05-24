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
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:sizer/sizer.dart';

class VerifyPhone extends StatelessWidget {
  VerifyPhone({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: true,
        widget: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
          child: ListView(
            children: [
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
                controller: emailController,
                hintText: translate(AppStrings.email),
                keyboardType: TextInputType.emailAddress,
              ),
              DefaultAppButton(
                title: translate(AppStrings.verify),
                width: 60.w,
                height: 5.h,
                onTap: () {
                  if (emailController.text == "") {
                    DefaultToast.showMyToast(translate(AppStrings.enterPhone));
                  } else {
                    IndicatorView.showIndicator();
                    AuthCubit(instance()).checkEmail(
                      email: emailController.text,
                      found: () {
                        AuthCubit(instance()).sendEmail(
                          email: emailController.text,
                          success: () {
                            NavigationService.pop();
                            NavigationService.pushNamed(
                              Routes.otp,
                              arguments: AppRouterArgument(
                                phone: emailController.text,
                                type: "resetPassword",
                              ),
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
                      notFound: () {
                        NavigationService.pop();
                        DefaultToast.showMyToast(
                          translate(AppStrings.phoneNotExist),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
