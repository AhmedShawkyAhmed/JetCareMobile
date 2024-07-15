import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:sizer/sizer.dart';

class DeletedAccountScreen extends StatefulWidget {
  const DeletedAccountScreen({super.key});

  @override
  State<DeletedAccountScreen> createState() => _DeletedAccountScreenState();
}

class _DeletedAccountScreenState extends State<DeletedAccountScreen> {
  ProfileCubit cubit = ProfileCubit(instance());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          hasBack: false,
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                height: 20.h,
                child: Image.asset("assets/images/block.png"),
              ),
              SizedBox(
                height: 5.h,
              ),
              DefaultText(
                text: translate(AppStrings.deleted),
              ),
              const Spacer(),
              DefaultAppButton(
                title: translate(AppStrings.restoreAccount),
                onTap: () {
                  cubit.restoreAccount();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
