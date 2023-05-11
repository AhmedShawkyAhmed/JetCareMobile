import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/notification_item.dart';

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
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return BodyView(
            hasBack: true,
            widget: ListView.builder(
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
            ),
          );
        },
      ),
    );
  }
}
