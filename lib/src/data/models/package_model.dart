import 'package:jetcare/src/data/models/item_model.dart';

class PackageModel {
  int? id;
  int? hasShipping;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? image;
  String? type;
  num? price;
  List<ItemModel>? items;
  List<PackageModel>? packages;

  PackageModel({
    this.id,
    this.hasShipping,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.image,
    this.type,
    this.price,
    this.items,
    this.packages,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json['id'] ?? 0,
    hasShipping: json['hasShipping'] ?? 0,
        nameAr: json['nameAr'] ?? "",
        nameEn: json['nameEn'] ?? "",
        descriptionAr: json['descriptionAr'] ?? "",
        descriptionEn: json['descriptionEn'] ?? "",
        image: json['image'] ?? "",
        type: json['type'] ?? "",
        price: json['price'] ?? 0,
        items: json["items"] != null
            ? List<ItemModel>.from(
                json["items"].map((x) => ItemModel.fromJson(x)))
            : json["items"],
    packages: json["package"] != null
        ? List<PackageModel>.from(
        json["package"].map((x) => PackageModel.fromJson(x)))
        : json["package"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'hasShipping': hasShipping,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'descriptionAr': descriptionAr,
        'descriptionEn': descriptionEn,
        'image': image,
        'type': type,
        'price': price,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "package": List<dynamic>.from(packages!.map((x) => x.toJson())),
      };
}
