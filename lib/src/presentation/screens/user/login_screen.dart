import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetcare/src/business_logic/language_cubit/language_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/data/network/requests/auth_request.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool password = true;
  bool singIn = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    onTap: CacheService.get(key: CacheKeys.language) == "ar"
                        ? () {
                            LanguageCubit().toEnglish(
                              afterSuccess: () {
                                NavigationService.pushNamedAndRemoveUntil(
                                    AppRouterNames.splash, (route) => false);
                              },
                            );
                          }
                        : () {
                            LanguageCubit().toArabic(
                              afterSuccess: () {
                                NavigationService.pushNamedAndRemoveUntil(
                                    AppRouterNames.splash, (route) => false);
                              },
                            );
                          },
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
                          text:
                              CacheService.get(key: CacheKeys.language) == "ar"
                                  ? "En"
                                  : "ع",
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
                          singIn = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          translate(AppStrings.login),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: singIn ? AppColors.primary : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          singIn = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          translate(AppStrings.register),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: singIn ? AppColors.white : AppColors.primary,
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
                  height: singIn ? 33.h : 17.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultTextField(
                        controller: emailController,
                        hintText: translate(AppStrings.email),
                        keyboardType: TextInputType.emailAddress,
                        marginVertical: 0,
                      ),
                      if (singIn)
                        DefaultTextField(
                          controller: passwordController,
                          hintText: translate(AppStrings.password),
                          password: password,
                          marginVertical: 0,
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                password = !password;
                              });
                            },
                            child: Icon(
                              password
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.primary,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      if (singIn)
                        GestureDetector(
                          onTap: () {
                            NavigationService.pushNamed(
                              AppRouterNames.verify,
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
                        title: singIn
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
                        onTap: singIn
                            ? () {
                                if (emailController.text == "") {
                                  DefaultToast.showMyToast(
                                      translate(AppStrings.enterEmail));
                                } else if (passwordController.text == "") {
                                  DefaultToast.showMyToast(
                                      translate(AppStrings.enterPassword));
                                } else {
                                  IndicatorView.showIndicator(context);
                                  AuthCubit(instance()).login(
                                    authRequest: AuthRequest(
                                      phone: emailController.text,
                                      password: passwordController.text,
                                    ),
                                    afterFail: () {
                                      NavigationService.pop();
                                    },
                                    disable: () {
                                      NavigationService.pushNamedAndRemoveUntil(
                                        AppRouterNames.disable,
                                        (route) => false,
                                      );
                                    },
                                    client: () {
                                      NavigationService.pushNamedAndRemoveUntil(
                                        AppRouterNames.layout,
                                        (route) => false,
                                      );
                                    },
                                    crew: () {
                                      NavigationService.pushNamedAndRemoveUntil(
                                        AppRouterNames.crewLayout,
                                        (route) => false,
                                      );
                                    },
                                  );
                                }
                              }
                            : () {
                                IndicatorView.showIndicator(context);
                                AuthCubit(instance()).checkEmail(
                                  email: emailController.text,
                                  notFound: () {
                                    AuthCubit(instance()).sendEmail(
                                      email: emailController.text,
                                      success: () {
                                        NavigationService
                                            .pushNamedAndRemoveUntil(
                                          AppRouterNames.otp,
                                          (route) => true,
                                          arguments: AppRouterArgument(
                                            type: "register",
                                            phone: emailController.text,
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
                                  found: () {
                                    NavigationService.pop();
                                    DefaultToast.showMyToast(
                                        translate(AppStrings.phoneExist));
                                  },
                                );
                              },
                      ),
                      if (singIn)
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
                            NavigationService.pushNamedAndRemoveUntil(
                              AppRouterNames.home,
                              (route) => false,
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.primary,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     RawMaterialButton(
                //       onPressed: () {},
                //       elevation: 2.0,
                //       fillColor: Colors.white,
                //       shape: const CircleBorder(),
                //       child: const Icon(
                //         Icons.facebook,
                //         size: 15.0,
                //       ),
                //     ),
                //     RawMaterialButton(
                //       onPressed: () {},
                //       elevation: 2.0,
                //       fillColor: Colors.white,
                //       shape: const CircleBorder(),
                //       child: const Icon(
                //         Icons.apple,
                //         size: 15.0,
                //       ),
                //     ),
                //     RawMaterialButton(
                //       onPressed: () {},
                //       elevation: 2.0,
                //       fillColor: Colors.white,
                //       shape: const CircleBorder(),
                //       child: const Icon(
                //         Icons.alternate_email,
                //         size: 15.0,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
