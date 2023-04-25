class SpaceModel {
  int? id;
  String? from;
  String? to;
  num? price;

  SpaceModel({
    this.id,
    this.from,
    this.to,
    this.price,
  });

  factory SpaceModel.fromJson(Map<String, dynamic> json) => SpaceModel(
    id: json['id'] ?? 0,
    from: json['from'] ?? "",
    to: json['to'] ?? "",
    price: json['price'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'from': from,
    'to': to,
    'price': price,
  };
}
