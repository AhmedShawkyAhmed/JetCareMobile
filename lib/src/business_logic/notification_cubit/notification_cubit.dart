import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/network/api_consumer.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/network/responses/global_response.dart';
import 'package:jetcare/src/data/network/responses/notification_response.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.networkService) : super(NotificationInitial());
  ApiConsumer networkService;

  NotificationResponse? notificationResponse;
  GlobalResponse? readNotificationResponse;

  Future getNotifications({
    required int userId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(GetNotificationLoadingState());
      await networkService.get(url: EndPoints.getNotifications, query: {
        "userId": userId,
      }).then((value) {
        notificationResponse = NotificationResponse.fromJson(value.data);
        printResponse(value.data.toString());
        emit(GetNotificationSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(GetNotificationErrorState());
      printError(n.toString());
    } catch (e) {
      emit(GetNotificationErrorState());
      printError(e.toString());
    }
  }

  Future readNotification({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(ReadNotificationLoadingState());
      await networkService.get(url: EndPoints.readNotification, query: {
        "id": id,
      }).then((value) {
        printResponse(value.data.toString());
        readNotificationResponse = GlobalResponse.fromJson(value.data);
        emit(ReadNotificationSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(ReadNotificationErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ReadNotificationErrorState());
      printError(e.toString());
    }
  }

  Future saveNotification({
    required String title,
    required String message,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SaveNotificationLoadingState());
      await networkService.post(
        url: EndPoints.saveNotification,
        body: {
          'userId': globalAccountModel.id,
          'title': title,
          'message': message,
        },
      ).then((value) {
        printResponse(value.data.toString());
        emit(SaveNotificationSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(SaveNotificationErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SaveNotificationErrorState());
      printError(e.toString());
    }
  }
}
