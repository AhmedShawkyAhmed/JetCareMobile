import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/notifications/cubit/notification_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/presentation/views/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationCubit cubit = BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: true,
        widget: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is GetNotificationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return cubit.notifications!.isNotEmpty
                ? const Center(
                    child: DefaultText(text: "لا يوجد إشعارات"),
                  )
                : ListView.builder(
                    itemCount: cubit.notifications!.length,
                    itemBuilder: (context, index) {
                      return NotificationItem(
                        id: cubit.notifications![index].id!,
                        title: cubit.notifications![index].title!,
                        message: cubit.notifications![index].message!,
                        createdAt: cubit.notifications![index].createdAt!,
                        isRead: cubit.notifications![index].isRead!,
                        onTap: () {
                          cubit.readNotification(
                            id: cubit.notifications![index].id!,
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
