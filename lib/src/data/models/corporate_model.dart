import 'package:jetcare/src/features/home/data/models/item_model.dart';

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

  factory CorporateModel.fromJson(Map<String, dynamic> json) => CorporateModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? "",
    email: json['email'] ?? "",
    phone: json['phone'] ?? "",
    message: json['message'] ?? "",
    createdAt: json['created_at'] ?? "",
    item: json["item"] != null
        ? ItemModel.fromJson(json["item"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'message': message,
    'email': email,
    'phone': phone,
    'created_at': createdAt,
    'item':item,
  };
}
