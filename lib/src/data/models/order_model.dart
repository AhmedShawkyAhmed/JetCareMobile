import 'package:jetcare/src/data/models/account_model.dart';
import 'package:jetcare/src/data/models/address_model.dart';
import 'package:jetcare/src/data/models/calender_model.dart';
import 'package:jetcare/src/data/models/cart_model.dart';
import 'package:jetcare/src/data/models/item_model.dart';
import 'package:jetcare/src/data/models/package_model.dart';
import 'package:jetcare/src/data/models/period_model.dart';

class OrderModel {
  int? id;
  String? status;
  String? createdAt, date, comment;
  num? total, price, shipping;
  AccountModel? user, crew;
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

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] ?? 0,
        total: json['total'] ?? 0,
        price: json['price'] ?? 0,
        shipping: json['shipping'] ?? 0,
        status: json['status'] ?? "",
        comment: json['comment'] ?? "",
        createdAt: json['created_at'] ?? "",
        date: json['date'] ?? "",
        user: json["user"] != null ? AccountModel.fromJson(json["user"]) : null,
        crew: json["crew"] != null ? AccountModel.fromJson(json["crew"]) : null,
        period: json["period"] != null
            ? PeriodModel.fromJson(json["period"])
            : null,
        address: json["address"] != null
            ? AddressModel.fromJson(json["address"])
            : null,
        package: json["package"] != null
            ? PackageModel.fromJson(json["package"])
            : null,
        item: json["item"] != null ? ItemModel.fromJson(json["item"]) : null,
        calendar: json["calendar"] != null
            ? CalenderModel.fromJson(json["calendar"])
            : null,
        extras: json["extras"] != null
            ? List<ItemModel>.from(
                json["extras"].map((x) => ItemModel.fromJson(x)))
            : json["extras"],
        cart: json["cart"] != null
            ? List<CartModel>.from(
                json["cart"].map((x) => CartModel.fromJson(x)))
            : json["cart"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'total': total,
        'price': price,
        'shipping': shipping,
        'status': status,
        'created_at': createdAt,
        'user': user,
        'crew': crew,
        'date': date,
        'period': period,
        'item': item,
        'address': address,
        'package': package,
        'calendar': calendar,
        'comment': comment,
        "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
        "cart": List<dynamic>.from(cart!.map((x) => x.toJson())),
      };
}
