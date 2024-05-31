import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  int? id;
  int? userId;
  bool? isRead;
  String? title;
  String? message;
  String? createdAt;

  NotificationModel({
    this.id,
    this.userId,
    this.isRead,
    this.title,
    this.message,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}