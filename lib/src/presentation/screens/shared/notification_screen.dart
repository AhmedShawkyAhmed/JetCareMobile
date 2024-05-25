import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

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
            if (NotificationCubit(instance()).notificationResponse?.status ==
                null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (NotificationCubit(instance())
                    .notificationResponse!
                    .status !=
                200) {
              return const Center(
                child: DefaultText(text: "لا يوجد إشعارات"),
              );
            }
            return ListView.builder(
              itemCount: NotificationCubit(instance())
                  .notificationResponse!
                  .notifications!
                  .length,
              itemBuilder: (context, index) {
                return NotificationItem(
                  id: NotificationCubit(instance())
                      .notificationResponse!
                      .notifications![index]
                      .id!,
                  title: NotificationCubit(instance())
                      .notificationResponse!
                      .notifications![index]
                      .title!,
                  message: NotificationCubit(instance())
                      .notificationResponse!
                      .notifications![index]
                      .message!,
                  createdAt: NotificationCubit(instance())
                      .notificationResponse!
                      .notifications![index]
                      .createdAt!,
                  isRead: NotificationCubit(instance())
                      .notificationResponse!
                      .notifications![index]
                      .isRead!,
                  onTap: () {
                    NotificationCubit(instance()).readNotification(
                      id: NotificationCubit(instance())
                          .notificationResponse!
                          .notifications![index]
                          .id!,
                      afterSuccess: () {
                        setState(() {
                          NotificationCubit(instance())
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
