// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpaceModel _$SpaceModelFromJson(Map<String, dynamic> json) => SpaceModel(
      id: (json['id'] as num?)?.toInt(),
      from: json['from'] as String?,
      to: json['to'] as String?,
      price: json['price'] as num?,
    );

Map<String, dynamic> _$SpaceModelToJson(SpaceModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('from', instance.from);
  writeNotNull('to', instance.to);
  writeNotNull('price', instance.price);
  return val;
}
