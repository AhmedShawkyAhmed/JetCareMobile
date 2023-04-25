class InfoModel{
  int? id;
  String? titleAr,titleEn,contentAr,contentEn;

  InfoModel({
    this.id,
    this.titleAr,
    this.titleEn,
    this.contentAr,
    this.contentEn,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    id: json["id"] ?? 0,
    titleAr: json["titleAr"] ?? "",
    titleEn: json["titleEn"] ?? "",
    contentAr: json["contentAr"] ?? "",
    contentEn: json["contentEn"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "titleAr": titleAr,
    "titleEn": titleEn,
    "contentAr": contentAr,
    "contentEn": contentEn,
  };

}