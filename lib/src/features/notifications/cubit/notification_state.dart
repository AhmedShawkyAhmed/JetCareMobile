part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class SaveNotificationLoading extends NotificationState {}
class SaveNotificationSuccess extends NotificationState {}
class SaveNotificationFailure extends NotificationState {}

class GetNotificationLoading extends NotificationState {}
class GetNotificationSuccess extends NotificationState {}
class GetNotificationFailure extends NotificationState {}

class ReadNotificationLoading extends NotificationState {}
class ReadNotificationSuccess extends NotificationState {}
class ReadNotificationFailure extends NotificationState {}
