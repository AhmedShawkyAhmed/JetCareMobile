import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_request.g.dart';

@JsonSerializable()
class FCMRequest {
  final int id;
  final String fcm;

  FCMRequest({
    required this.id,
    required this.fcm,
  });

  factory FCMRequest.fromJson(Map<String, dynamic> json) =>
      _$FCMRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FCMRequestToJson(this);
}
