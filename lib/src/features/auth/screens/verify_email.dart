import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    late AuthCubit cubit = BlocProvider.of(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
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
                    controller: cubit.emailController,
                    hintText: translate(AppStrings.email),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  DefaultAppButton(
                    title: translate(AppStrings.verify),
                    width: 60.w,
                    height: 5.h,
                    onTap: () {
                      cubit.checkEmail(type: OTPTypes.resetPassword);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
