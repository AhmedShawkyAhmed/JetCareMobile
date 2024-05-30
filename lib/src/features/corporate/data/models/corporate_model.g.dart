// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorporateModel _$CorporateModelFromJson(Map<String, dynamic> json) =>
    CorporateModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      message: json['message'] as String?,
      createdAt: json['created_at'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      item: json['item'] == null
          ? null
          : ItemModel.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CorporateModelToJson(CorporateModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('message', instance.message);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('item', instance.item?.toJson());
  return val;
}
