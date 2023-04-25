
import 'package:jetcare/src/data/models/period_model.dart';

class PeriodResponse {
  int? status;
  String? message;
  List<PeriodModel>? periods;

  PeriodResponse({
    this.status,
    this.message,
    this.periods,
  });

  factory PeriodResponse.fromJson(Map<String, dynamic> json) =>
      PeriodResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        periods: json["periodList"] != null
            ? List<PeriodModel>.from(
            json["periodList"].map((x) => PeriodModel.fromJson(x)))
            : json["periodList"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "periodList": List<dynamic>.from(periods!.map((x) => x.toJson())),
  };
}
