import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_order_status_request.g.dart';

@JsonSerializable()
class UpdateOrderStatusRequest {
  int id;
  String status;
  String? reason;

  UpdateOrderStatusRequest({
    required this.id,
    required this.status,
    this.reason,
  });

  factory UpdateOrderStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderStatusRequestToJson(this);
}
