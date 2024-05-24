// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordRequest _$ForgetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordRequest(
      password: json['password'] as String,
      newPassword: json['new_password'] as String,
    );

Map<String, dynamic> _$ForgetPasswordRequestToJson(
        ForgetPasswordRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'new_password': instance.newPassword,
    };
