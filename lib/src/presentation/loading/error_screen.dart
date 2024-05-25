import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';

customError() {
  ErrorWidget.builder = (FlutterErrorDetails error) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/images/rror.png')),
          const SizedBox(
            height: 30,
          ),
          DefaultText(
            text: error.toString(),
            textColor: AppColors.black,
          ),
        ],
      ),
    );
  };
}
