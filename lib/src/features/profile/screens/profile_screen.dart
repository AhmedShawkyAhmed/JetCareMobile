import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
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
        widget: Column(
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
        ),
      ),
    );
  }
}
