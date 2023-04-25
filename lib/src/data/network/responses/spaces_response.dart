import 'package:jetcare/src/data/models/space_model.dart';

class SpaceResponse {
  int? status;
  String? message;
  List<SpaceModel>? spaces;

  SpaceResponse({
    this.status,
    this.message,
    this.spaces,
  });

  factory SpaceResponse.fromJson(Map<String, dynamic> json) =>
      SpaceResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        spaces: json["spaceList"] != null
            ? List<SpaceModel>.from(
            json["spaceList"].map((x) => SpaceModel.fromJson(x)))
            : json["spaceList"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "spaceList": List<dynamic>.from(spaces!.map((x) => x.toJson())),
  };
}
