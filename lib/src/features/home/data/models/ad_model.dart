import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_model.g.dart';

@JsonSerializable()
class AdModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? link;
  String? image;

  AdModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.link,
    this.image,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) =>
      _$AdModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdModelToJson(this);
}
