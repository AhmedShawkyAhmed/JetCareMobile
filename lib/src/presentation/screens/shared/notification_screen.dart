import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/notification_item.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: true,
        widget: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (NotificationCubit.get(context).notificationResponse?.status ==
                null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (NotificationCubit.get(context)
                    .notificationResponse!
                    .status !=
                200) {
              return const Center(
                child: DefaultText(text: "لا يوجد إشعارات"),
              );
            }
            return ListView.builder(
              itemCount: NotificationCubit.get(context)
                  .notificationResponse!
                  .notifications!
                  .length,
              itemBuilder: (context, index) {
                return NotificationItem(
                  id: NotificationCubit.get(context)
                      .notificationResponse!
                      .notifications![index]
                      .id!,
                  title: NotificationCubit.get(context)
                      .notificationResponse!
                      .notifications![index]
                      .title!,
                  message: NotificationCubit.get(context)
                      .notificationResponse!
                      .notifications![index]
                      .message!,
                  createdAt: NotificationCubit.get(context)
                      .notificationResponse!
                      .notifications![index]
                      .createdAt!,
                  isRead: NotificationCubit.get(context)
                      .notificationResponse!
                      .notifications![index]
                      .isRead!,
                  onTap: () {
                    NotificationCubit.get(context).readNotification(
                      id: NotificationCubit.get(context)
                          .notificationResponse!
                          .notifications![index]
                          .id!,
                      afterSuccess: () {
                        setState(() {
                          NotificationCubit.get(context)
                              .notificationResponse!
                              .notifications![index]
                              .isRead = 1;
                        });
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
