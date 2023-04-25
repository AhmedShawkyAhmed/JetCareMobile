class ItemModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? image;
  String? type;
  num? price;
  String? unit;
  num? quantity;

  ItemModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.image,
    this.type,
    this.price,
    this.unit,
    this.quantity,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json['id'] ?? 0,
        nameAr: json['nameAr'] ?? "",
        nameEn: json['nameEn'] ?? "",
        descriptionAr: json['descriptionAr'] ?? "",
        descriptionEn: json['descriptionEn'] ?? "",
        image: json['image'] ?? "",
        type: json['type'] ?? "",
        price: json['price'] ?? 0,
        unit: json['unit'] ?? "",
        quantity: json['quantity'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'descriptionAr': descriptionAr,
        'descriptionEn': descriptionEn,
        'image': image,
        'type': type,
        'price': price,
        'unit': unit,
        'quantity': quantity,
      };
}
