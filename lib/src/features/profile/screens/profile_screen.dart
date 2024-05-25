import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit cubit = BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.mainColor,
          body: BodyView(
            widget: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                DefaultTextField(
                  controller: cubit.nameController,
                  hintText: Globals.userData.name ?? "",
                  enabled: cubit.update,
                ),
                DefaultTextField(
                  controller: cubit.phoneController,
                  hintText: Globals.userData.phone ?? "",
                  enabled: cubit.update,
                ),
                DefaultTextField(
                  controller: cubit.emailController,
                  hintText: Globals.userData.email ?? '',
                  enabled: cubit.update,
                ),
                const Spacer(),
                DefaultAppButton(
                  title: cubit.update
                      ? translate(AppStrings.save)
                      : translate(AppStrings.update),
                  isGradient: !cubit.update,
                  gradientColors: const [AppColors.grey, AppColors.grey],
                  onTap: () {
                    if(cubit.update){
                      cubit.updateProfile();
                    }else{
                      setState(() {
                        cubit.update = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
