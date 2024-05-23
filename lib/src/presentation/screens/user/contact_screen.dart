import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/data/network/requests/support_request.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:sizer/sizer.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                  ),
                  child: DefaultText(
                    text: translate(AppStrings.contactUs),
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
            Container(
              width: 80.w,
              height: 15.h,
              padding: EdgeInsets.all(3.w),
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.shade.withOpacity(0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    text: "${translate(AppStrings.email)} : ${GlobalCubit(instance()).infoResponse!.contact!.contentAr}",
                    fontSize: 11.sp,
                  ),
                  DefaultText(
                    text: "${translate(AppStrings.phone)} : ${GlobalCubit(instance()).infoResponse!.contact!.contentEn}",
                    fontSize: 11.sp,
                  ),
                ],
              ),
            ),
            DefaultTextField(
              controller: nameController,
              hintText: translate(AppStrings.name),
            ),
            DefaultTextField(
              controller: contactController,
              hintText: translate(AppStrings.contact),
            ),
            DefaultTextField(
              controller: subjectController,
              hintText: translate(AppStrings.subject),
            ),
            DefaultTextField(
              controller: messageController,
              hintText: translate(AppStrings.message),
              maxLine: 10,
              height: 25.h,
              maxLength: 500,
            ),
            DefaultAppButton(
                title: translate(AppStrings.send),
                onTap: () {
                  if (nameController.text == "") {
                    DefaultToast.showMyToast(translate(AppStrings.enterName));
                  } else if (contactController.text == "") {
                    DefaultToast.showMyToast(
                        translate(AppStrings.enterContact));
                  } else if (subjectController.text == "") {
                    DefaultToast.showMyToast(
                        translate(AppStrings.enterSubject));
                  } else if (messageController.text == "") {
                    DefaultToast.showMyToast(
                        translate(AppStrings.enterMessage));
                  } else {
                    GlobalCubit(instance()).support(
                      supportRequest: SupportRequest(
                        name: nameController.text,
                        contact: contactController.text,
                        subject: subjectController.text,
                        message: messageController.text,
                      ),
                      afterSuccess: () {
                        NavigationService.pushReplacementNamed(

                          Routes.success,
                          arguments: AppRouterArgument(
                            type: "support",
                          ),
                        );
                      },
                    );
                  }
                }),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
