// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderStatusRequest _$UpdateOrderStatusRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderStatusRequest(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$UpdateOrderStatusRequestToJson(
    UpdateOrderStatusRequest instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reason', instance.reason);
  return val;
}
