import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/features/language/cubit/language_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthCubit cubit = AuthCubit(instance());

  @override
  void dispose() {
    cubit.emailController.dispose();
    cubit.passwordController.dispose();
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
              widget: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: LanguageCubit().changeLanguage,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: DefaultText(
                                text: isArabic ? "En" : "ع",
                                fontSize: 13.sp,
                                align: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                cubit.singIn = true;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                translate(AppStrings.login),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: cubit.singIn
                                      ? AppColors.primary
                                      : AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                cubit.singIn = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                translate(AppStrings.register),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: cubit.singIn
                                      ? AppColors.white
                                      : AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(6),
                        width: 80.w,
                        height: cubit.singIn ? 33.h : 17.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DefaultTextField(
                              controller: cubit.emailController,
                              hintText: translate(AppStrings.email),
                              keyboardType: TextInputType.emailAddress,
                              marginVertical: 0,
                            ),
                            if (cubit.singIn)
                              DefaultTextField(
                                controller: cubit.passwordController,
                                hintText: translate(AppStrings.password),
                                password: cubit.password,
                                marginVertical: 0,
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      cubit.password = !cubit.password;
                                    });
                                  },
                                  child: Icon(
                                    cubit.password
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.primary,
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                            if (cubit.singIn)
                              GestureDetector(
                                onTap: () {
                                  NavigationService.pushNamed(
                                    Routes.verify,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    translate(AppStrings.forgetPassword),
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            DefaultAppButton(
                              marginVertical: 5,
                              title: cubit.singIn
                                  ? translate(AppStrings.login)
                                  : translate(AppStrings.verify),
                              width: 60.w,
                              height: 5.h,
                              radius: 12,
                              isGradient: true,
                              gradientColors: const [
                                AppColors.primary,
                                AppColors.primaryLight
                              ],
                              onTap: () {
                                if (cubit.singIn) {
                                  cubit.login();
                                } else {
                                  cubit.checkEmail(type: OTPTypes.register);
                                }
                              },
                            ),
                            if (cubit.singIn)
                              DefaultAppButton(
                                marginVertical: 0,
                                width: 60.w,
                                height: 5.h,
                                radius: 12,
                                isGradient: true,
                                gradientColors: const [
                                  AppColors.primary,
                                  AppColors.primaryLight
                                ],
                                title: translate(AppStrings.guest),
                                onTap: () {
                                  NavigationService.pushNamed(
                                    Routes.home,
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
