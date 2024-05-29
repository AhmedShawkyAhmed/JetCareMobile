import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetcare/src/data/models/calender_model.dart';
import 'package:jetcare/src/data/models/cart_model.dart';
import 'package:jetcare/src/data/models/item_model.dart';
import 'package:jetcare/src/data/models/package_model.dart';
import 'package:jetcare/src/data/models/period_model.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  int? id;
  String? status;
  String? createdAt, date, comment;
  num? total, price, shipping;
  UserModel? user, crew;
  PeriodModel? period;
  AddressModel? address;
  PackageModel? package;
  ItemModel? item;
  CalenderModel? calendar;
  List<ItemModel>? extras;
  List<CartModel>? cart;

  OrderModel({
    this.id,
    this.status,
    this.createdAt,
    this.total,
    this.price,
    this.shipping,
    this.user,
    this.crew,
    this.date,
    this.item,
    this.period,
    this.address,
    this.package,
    this.calendar,
    this.extras,
    this.cart,
    this.comment,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}