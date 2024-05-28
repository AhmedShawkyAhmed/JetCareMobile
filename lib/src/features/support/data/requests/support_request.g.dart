// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportRequest _$SupportRequestFromJson(Map<String, dynamic> json) =>
    SupportRequest(
      name: json['name'] as String?,
      contact: json['contact'] as String?,
      subject: json['subject'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SupportRequestToJson(SupportRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('contact', instance.contact);
  writeNotNull('subject', instance.subject);
  writeNotNull('message', instance.message);
  return val;
}
