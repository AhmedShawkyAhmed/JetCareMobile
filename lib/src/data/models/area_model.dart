class AreaModel {
  int? id;
  String? nameAr;
  String? nameEn;
  num? price;

  AreaModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
    id: json['id'] ?? 0,
    nameAr: json['nameAr'] ?? "",
    nameEn: json['nameEn'] ?? "",
    price: json['price'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameAr': nameAr,
    'nameEn': nameEn,
    'price': price,
  };
}
