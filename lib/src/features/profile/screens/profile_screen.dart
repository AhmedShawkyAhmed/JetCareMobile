import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const ProfileScreen({
    required this.appRouterArgument,
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool update = false;
  bool password = true;
  bool confirm = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: widget.appRouterArgument.type == "profile"
            ? Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  DefaultTextField(
                    controller: nameController,
                    hintText: globalAccountModel.name ?? "",
                    enabled: update,
                  ),
                  DefaultTextField(
                    controller: phoneController,
                    hintText: globalAccountModel.phone ?? "",
                    enabled: update,
                  ),
                  DefaultTextField(
                    controller: emailController,
                    hintText: globalAccountModel.email ?? '',
                    enabled: update,
                  ),
                  const Spacer(),
                  DefaultAppButton(
                    title: update
                        ? translate(AppStrings.save)
                        : translate(AppStrings.update),
                    isGradient: !update,
                    gradientColors: const [AppColors.grey, AppColors.grey],
                    onTap: () {
                      setState(() {
                        update = !update;
                      });
                      if (!update) {
                        if (nameController.text == "" &&
                            phoneController.text == "" &&
                            emailController.text == "") {
                          DefaultToast.showMyToast(
                              translate(AppStrings.updateProfile));
                        } else {
                          // TODO update profile
                          // AuthCubit(instance()).updateAccount(
                          //   accountRequest: AccountRequest(
                          //     name: nameController.text == ""
                          //         ? null
                          //         : nameController.text,
                          //     phone: phoneController.text == ""
                          //         ? null
                          //         : phoneController.text,
                          //     email: emailController.text == ""
                          //         ? null
                          //         : emailController.text,
                          //   ),
                          //   afterSuccess: () {
                          //     nameController.clear();
                          //     phoneController.clear();
                          //     emailController.clear();
                          //     DefaultToast.showMyToast(
                          //         translate(AppStrings.saveData));
                          //     NavigationService.pop();
                          //   },
                          // );
                        }
                      }
                    },
                  ),
                ],
              )
            : ListView(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                children: [
                  DefaultTextField(
                    controller: nameController,
                    hintText: translate(AppStrings.name),
                  ),
                  DefaultTextField(
                    controller: emailController,
                    hintText: widget.appRouterArgument.phone.toString(),
                    enabled: false,
                  ),
                  DefaultTextField(
                    controller: phoneController,
                    hintText: translate(AppStrings.phone),
                    keyboardType: TextInputType.phone,
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
                    height: 3.h,
                  ),
                  DefaultAppButton(
                    title: translate(AppStrings.register),
                    onTap: () {
                      setState(() {
                        update = !update;
                      });
                      if (!update) {
                        AuthCubit(instance()).register();
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
