import 'package:jetcare/src/data/models/corporate_model.dart';

class CorporateResponse {
  int? status;
  String? message;
  CorporateModel? corporateModel;

  CorporateResponse({this.status, this.message, this.corporateModel});

  factory CorporateResponse.fromJson(Map<String, dynamic> json) => CorporateResponse(
    status: json['status'] ?? 0,
    message: json['message'] ?? "",
    corporateModel: json["order"] != null
        ? CorporateModel.fromJson(json["order"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message":message,
    "order": corporateModel,
  };
}