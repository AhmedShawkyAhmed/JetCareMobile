// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailRequest _$MailRequestFromJson(Map<String, dynamic> json) => MailRequest(
      email: json['email'] as String,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MailRequestToJson(MailRequest instance) {
  final val = <String, dynamic>{
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  return val;
}
