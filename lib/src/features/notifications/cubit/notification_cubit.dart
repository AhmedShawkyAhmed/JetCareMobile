import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/services/notification_service.dart';
import 'package:jetcare/src/features/notifications/data/models/notification_model.dart';
import 'package:jetcare/src/features/notifications/data/repo/notification_repo.dart';
import 'package:jetcare/src/features/notifications/data/requests/notification_request.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repo) : super(NotificationInitial());

  final NotificationRepo repo;

  List<NotificationModel> notifications = [];

  Future saveNotification({
    required NotificationRequest request,
  }) async {
    emit(SaveNotificationLoading());
    var response = await repo.saveNotification(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NotificationService().showNotification(
          id: 12,
          title: request.title,
          body: request.message,
        );
        emit(SaveNotificationSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(SaveNotificationFailure());
      },
    );
  }

  Future getNotifications() async {
    notifications.clear();
    emit(GetNotificationLoading());
    var response = await repo.getNotifications();
    response.when(
      success: (NetworkBaseModel response) async {
        notifications = response.data;
        emit(GetNotificationSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetNotificationFailure());
      },
    );
  }

  Future readNotification({
    required int id,
  }) async {
    emit(ReadNotificationSuccess());
    var response = await repo.readNotification(id: id);
    response.when(
      success: (NetworkBaseModel response) async {
        emit(ReadNotificationSuccess());
        await readLocalNotification(id: id);
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(ReadNotificationFailure());
      },
    );
  }

  Future readLocalNotification({
    required int id,
  }) async {
    if (notifications.isNotEmpty) {
      notifications.firstWhere((n) => n.id == id).isRead = true;
    }
  }
}
