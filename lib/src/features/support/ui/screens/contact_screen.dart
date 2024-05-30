import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/features/shared/ui/views/body_view.dart';
import 'package:jetcare/src/features/shared/ui/views/loading_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text_field.dart';
import 'package:jetcare/src/features/support/cubit/support_cubit.dart';
import 'package:jetcare/src/features/support/data/requests/support_request.dart';
import 'package:sizer/sizer.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late SupportCubit cubit = BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();

  TextEditingController contactController = TextEditingController();

  TextEditingController subjectController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: BlocBuilder<SupportCubit, SupportState>(
          builder: (context, state) {
            if (state is GetContactsLoading) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return LoadingView(
                    height: 15.h,
                  );
                },
              );
            }
            return ListView(
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
                  margin: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.shade.withOpacity(0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        text:
                        "${translate(AppStrings.email)} : ${cubit.contacts
                            ?.contentAr ?? "-"}",
                        fontSize: 11.sp,
                      ),
                      DefaultText(
                        text:
                        "${translate(AppStrings.phone)} : ${cubit.contacts
                            ?.contentEn ?? "-"}",
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
                    cubit.addSupport(
                      request: SupportRequest(
                        name: nameController.text,
                        contact: contactController.text,
                        subject: subjectController.text,
                        message: messageController.text,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
