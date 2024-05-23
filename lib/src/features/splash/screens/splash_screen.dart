import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/splash/cubit/splash_cubit.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.mainColor,
          body: BodyView(
            hasBack: false,
            widget: Center(
              child: Image.asset(
                "assets/images/translogow.png",
                width: 70.w,
              ),
            ),
          ),
        );
      },
    );
  }
}
