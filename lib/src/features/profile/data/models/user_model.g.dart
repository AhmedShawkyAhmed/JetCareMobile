// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      rate: json['rate'] as num?,
      role: json['role'] as String?,
      token: json['token'] as String?,
      active: (json['active'] as num?)?.toInt(),
      archive: (json['archive'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'rate': instance.rate,
      'role': instance.role,
      'token': instance.token,
      'active': instance.active,
      'archive': instance.archive,
    };
