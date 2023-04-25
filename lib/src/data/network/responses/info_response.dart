import 'package:jetcare/src/data/models/info_model.dart';

class InfoResponse {
  int? status;
  InfoModel? terms,about,contact;

  InfoResponse({
    this.status,
    this.terms,
    this.about,
    this.contact,
  });

  factory InfoResponse.fromJson(Map<String, dynamic> json) =>
      InfoResponse(
        status: json['status'] ?? 0,
        terms: json["terms"] != null
            ? InfoModel.fromJson(json["terms"])
            : null,
        about: json["about"] != null
            ? InfoModel.fromJson(json["about"])
            : null,
        contact: json["contact"] != null
            ? InfoModel.fromJson(json["contact"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "terms": terms,
    "about": about,
    "contact": contact,
  };
}
