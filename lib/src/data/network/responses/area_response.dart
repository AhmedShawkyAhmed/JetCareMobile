import 'package:jetcare/src/data/models/area_model.dart';

class AreaResponse {
  int? status;
  String? message;
  List<AreaModel>? areas;

  AreaResponse({
    this.status,
    this.message,
    this.areas,
  });

  factory AreaResponse.fromJson(Map<String, dynamic> json) =>
      AreaResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        areas: json["areaList"] != null
            ? List<AreaModel>.from(
            json["areaList"].map((x) => AreaModel.fromJson(x)))
            : json["areaList"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "areaList": List<dynamic>.from(areas!.map((x) => x.toJson())),
  };
}
