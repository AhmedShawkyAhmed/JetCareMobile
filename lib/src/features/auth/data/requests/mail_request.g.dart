// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailRequest _$MailRequestFromJson(Map<String, dynamic> json) => MailRequest(
      email: json['email'] as String,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MailRequestToJson(MailRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
