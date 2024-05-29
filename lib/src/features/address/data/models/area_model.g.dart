// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaModel _$AreaModelFromJson(Map<String, dynamic> json) => AreaModel(
      id: (json['id'] as num?)?.toInt(),
      stateId: (json['state_id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameAr: json['name_ar'] as String?,
      price: json['price'] as num?,
      discount: json['discount'] as num?,
      transportation: json['transportation'] as num?,
    );

Map<String, dynamic> _$AreaModelToJson(AreaModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('state_id', instance.stateId);
  writeNotNull('name_en', instance.nameEn);
  writeNotNull('name_ar', instance.nameAr);
  writeNotNull('price', instance.price);
  writeNotNull('discount', instance.discount);
  writeNotNull('transportation', instance.transportation);
  return val;
}
