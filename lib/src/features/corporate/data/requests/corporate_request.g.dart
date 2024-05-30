// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorporateRequest _$CorporateRequestFromJson(Map<String, dynamic> json) =>
    CorporateRequest(
      userId: (json['user_id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      itemId: (json['item_id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$CorporateRequestToJson(CorporateRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'item_id': instance.itemId,
      'message': instance.message,
    };
