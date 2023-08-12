class AreaModel {
  int? id;
  String? nameEn;
  String? nameAr;
  num? price;
  num? discount;
  int? active;
  int? relationId;

  AreaModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.price,
    this.discount,
    this.active,
    this.relationId,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
    id: json['id'] ?? 0,
    nameEn: json['nameEn'],
    nameAr: json['nameAr'],
    price: json['price'] ?? 0,
    discount: json['discount'] ?? 0,
    active: json['active'] ?? 0,
    relationId: json['relationId'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameAr': nameAr,
    'nameEn': nameEn,
    'price': price,
    'discount': discount,
    'active': active,
    'relationId': relationId,
  };
}
