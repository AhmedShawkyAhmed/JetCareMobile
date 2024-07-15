import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/routing/arguments/password_arguments.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatefulWidget {
  final PasswordArguments arguments;

  const ResetPassword({
    required this.arguments,
    super.key,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AuthCubit cubit = AuthCubit(instance());

  @override
  void dispose() {
    cubit.passwordController.dispose();
    cubit.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
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
                    controller: cubit.passwordController,
                    hintText: translate(AppStrings.password),
                    password: cubit.password,
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          cubit.password = !cubit.password;
                        });
                      },
                      child: Icon(
                        cubit.password ? Icons.visibility : Icons
                            .visibility_off,
                        color: AppColors.primary,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  DefaultTextField(
                    controller: cubit.confirmPasswordController,
                    hintText: translate(AppStrings.conPass),
                    password: cubit.confirm,
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          cubit.confirm = !cubit.confirm;
                        });
                      },
                      child: Icon(
                        cubit.confirm ? Icons.visibility : Icons.visibility_off,
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
                      cubit.resetPassword(
                        email: widget.arguments.email,
                      );
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
        },
      ),
    );
  }
}
