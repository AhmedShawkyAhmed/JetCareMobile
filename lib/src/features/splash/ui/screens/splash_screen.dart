import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/splash/cubit/splash_cubit.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashCubit cubit = SplashCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..init(),
      child: BlocBuilder<SplashCubit, SplashState>(
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
      ),
    );
  }
}
