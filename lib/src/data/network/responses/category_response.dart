import 'package:jetcare/src/data/models/item_model.dart';
import 'package:jetcare/src/data/models/package_model.dart';

class CategoryResponse {
  int? status;
  String? message;
  PackageModel? packageModel;
  PackageModel? categoryModel;
  List<ItemModel>? items;

  CategoryResponse({
    this.status,
    this.message,
    this.packageModel,
    this.categoryModel,
    this.items,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        packageModel:
            json["data"] != null ? PackageModel.fromJson(json["data"]) : null,
        categoryModel: json["category"] != null
            ? PackageModel.fromJson(json["category"])
            : null,
        items: json["items"] != null
            ? List<ItemModel>.from(
                json["items"].map((x) => ItemModel.fromJson(x)))
            : json["items"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": packageModel,
        "category": categoryModel,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
