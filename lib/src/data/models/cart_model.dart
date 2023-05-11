
import 'package:jetcare/src/data/models/package_model.dart';

class CartModel{
  int id;
  int userId;
  num count;
  num price;
  String status;
  PackageModel? package;
  PackageModel? item;

  CartModel({
    required this.id,
    required this.userId,
    required this.count,
    required this.status,
    required this.price,
    this.item,
    this.package,
});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'] ?? 0,
    userId: json['userId'] ?? 0,
    count: json['count'] ?? 0,
    price: json['price'] ?? 0,
    status: json['status'] ?? "",
    item:  json['items'] != null ? PackageModel.fromJson(json['items']) : null,
    package:  json['packages'] != null ? PackageModel.fromJson(json['packages']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'count': count,
    'price': price,
    'status': status,
    'items': item,
    'packages': package,
  };
}