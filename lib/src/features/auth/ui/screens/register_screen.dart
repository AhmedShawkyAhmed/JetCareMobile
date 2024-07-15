import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/routing/arguments/register_arguments.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/features/auth/data/requests/register_request.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  final RegisterArguments arguments;

  const RegisterScreen({
    required this.arguments,
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthCubit cubit = AuthCubit(instance());

  @override
  void dispose() {
    cubit.nameController.dispose();
    cubit.emailController.dispose();
    cubit.phoneController.dispose();
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
              widget: ListView(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                children: [
                  DefaultTextField(
                    controller: cubit.nameController,
                    hintText: translate(AppStrings.name),
                  ),
                  DefaultTextField(
                    controller: cubit.emailController,
                    hintText: widget.arguments.email,
                    enabled: false,
                  ),
                  DefaultTextField(
                    controller: cubit.phoneController,
                    hintText: translate(AppStrings.phone),
                    keyboardType: TextInputType.phone,
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
                        cubit.password
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                    height: 3.h,
                  ),
                  DefaultAppButton(
                    title: translate(AppStrings.register),
                    onTap: () {
                      AuthCubit(instance()).register(
                        request: RegisterRequest(
                          name: cubit.nameController.text,
                          phone: cubit.phoneController.text,
                          role: Roles.client.name,
                          email: widget.arguments.email,
                          password: cubit.passwordController.text,
                          confirmPassword: cubit.confirmPasswordController.text,
                        ),
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
