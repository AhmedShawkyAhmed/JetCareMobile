import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  int? id;
  num? count;
  num? price;
  String? status;
  PackageModel? package;
  PackageModel? item;

  CartItemModel({
    this.id,
    this.status,
    this.price,
    this.count,
    this.package,
    this.item,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
