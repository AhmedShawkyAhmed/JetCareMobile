import 'package:jetcare/src/data/models/calendar_model.dart';

class CalendarResponse {
  int? status;
  String? message;
  List<CalendarModel>? calendar;

  CalendarResponse({
    this.status,
    this.message,
    this.calendar,
  });

  factory CalendarResponse.fromJson(Map<String, dynamic> json) =>
      CalendarResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        calendar: json["dateList"] != null
            ? List<CalendarModel>.from(
            json["dateList"].map((x) => CalendarModel.fromJson(x)))
            : json["dateList"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "dateList": List<dynamic>.from(calendar!.map((x) => x.toJson())),
  };
}
