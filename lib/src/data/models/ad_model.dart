class AdModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? link;
  String? image;

  AdModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.link,
    this.image,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
        id: json['id'] ?? 0,
        nameAr: json['nameAr'] ?? "",
        nameEn: json['nameEn'] ?? "",
        link: json['link'] ?? "",
        image: json['image'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'link': link,
        'image': image,
      };
}
