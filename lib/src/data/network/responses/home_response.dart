import 'package:jetcare/src/data/models/ad_model.dart';
import 'package:jetcare/src/data/models/item_model.dart';
import 'package:jetcare/src/data/models/package_model.dart';

class HomeResponse {
  int? status;
  String? message;
  List<AdModel>? adsModel;
  List<PackageModel>? categoryModel, packageModel, serviceModel;
  List<ItemModel>? corporateModel, extraModel;

  HomeResponse({
    this.status,
    this.message,
    this.adsModel,
    this.categoryModel,
    this.packageModel,
    this.serviceModel,
    this.corporateModel,
    this.extraModel,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        adsModel: json["ads"] != null
            ? List<AdModel>.from(json["ads"].map((x) => AdModel.fromJson(x)))
            : json["ads"],
        categoryModel: json["category"] != null
            ? List<PackageModel>.from(
                json["category"].map((x) => PackageModel.fromJson(x)))
            : json["category"],
        packageModel: json["package"] != null
            ? List<PackageModel>.from(
                json["package"].map((x) => PackageModel.fromJson(x)))
            : json["package"],
        serviceModel: json["service"] != null
            ? List<PackageModel>.from(
                json["service"].map((x) => PackageModel.fromJson(x)))
            : json["service"],
        corporateModel: json["corporate"] != null
            ? List<ItemModel>.from(
                json["corporate"].map((x) => ItemModel.fromJson(x)))
            : json["corporate"],
        extraModel: json["extra"] != null
            ? List<ItemModel>.from(
                json["extra"].map((x) => ItemModel.fromJson(x)))
            : json["extra"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "ads": List<dynamic>.from(adsModel!.map((x) => x.toJson())),
        "category": List<dynamic>.from(categoryModel!.map((x) => x.toJson())),
        "package": List<dynamic>.from(packageModel!.map((x) => x.toJson())),
        "service": List<dynamic>.from(serviceModel!.map((x) => x.toJson())),
        "corporate": List<dynamic>.from(corporateModel!.map((x) => x.toJson())),
        "extra": List<dynamic>.from(extraModel!.map((x) => x.toJson())),
      };
}
