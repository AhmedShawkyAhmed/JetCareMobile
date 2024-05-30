import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetcare/src/features/home/data/models/item_model.dart';

part 'corporate_model.g.dart';

@JsonSerializable()
class CorporateModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? message;
  String? createdAt;
  ItemModel? item;

  CorporateModel({
    this.id,
    this.name,
    this.message,
    this.createdAt,
    this.email,
    this.phone,
    this.item,
  });

  factory CorporateModel.fromJson(Map<String, dynamic> json) =>
      _$CorporateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CorporateModelToJson(this);
}
