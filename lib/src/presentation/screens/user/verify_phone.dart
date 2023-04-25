import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class VerifyPhone extends StatelessWidget {
  VerifyPhone({Key? key}) : super(key: key);

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
                    IndicatorView.showIndicator(context);
                    AuthCubit.get(context).checkEmail(
                      email: emailController.text,
                      found: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          AppRouterNames.resetPassword,
                          arguments: AppRouterArgument(
                            phone: emailController.text,
                            type: "resetPassword",
                          ),
                        );
                        // AuthCubit.get(context).sendEmail(
                        //   email: emailController.text,
                        //   success: () {
                        //     Navigator.pop(context);
                        //     Navigator.pushNamed(
                        //       context,
                        //       AppRouterNames.resetPassword,
                        //       arguments: AppRouterArgument(
                        //         phone: emailController.text,
                        //         type: "resetPassword",
                        //       ),
                        //     );
                        //   },
                        //   failed: () {
                        //     Navigator.pop(context);
                        //     DefaultToast.showMyToast(
                        //       translate(AppStrings.error),
                        //     );
                        //   },
                        // );
                      },
                      notFound: () {
                        Navigator.pop(context);
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
