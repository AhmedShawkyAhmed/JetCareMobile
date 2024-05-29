import 'package:freezed_annotation/freezed_annotation.dart';

part 'area_model.g.dart';

@JsonSerializable()
class AreaModel {
  int? id;
  int? stateId;
  String? nameEn;
  String? nameAr;
  num? price;
  num? discount;
  num? transportation;

  AreaModel({
    this.id,
    this.stateId,
    this.nameEn,
    this.nameAr,
    this.price,
    this.discount,
    this.transportation,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) =>
      _$AreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaModelToJson(this);
}