// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: (json['id'] as num?)?.toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      price: json['price'] as num?,
      unit: json['unit'] as String?,
      quantity: json['quantity'] as num?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name_ar', instance.nameAr);
  writeNotNull('name_en', instance.nameEn);
  writeNotNull('description_ar', instance.descriptionAr);
  writeNotNull('description_en', instance.descriptionEn);
  writeNotNull('image', instance.image);
  writeNotNull('type', instance.type);
  writeNotNull('price', instance.price);
  writeNotNull('unit', instance.unit);
  writeNotNull('quantity', instance.quantity);
  return val;
}
