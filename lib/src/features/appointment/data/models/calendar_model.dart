import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';
import 'package:jetcare/src/features/appointment/data/models/period_model.dart';

part 'calendar_model.g.dart';

@JsonSerializable()
class CalendarModel {
  int? id;
  @JsonKey(name: "db_date")
  String? date;
  int? year;
  int? month;
  int? day;
  String? dayName;
  String? monthName;
  List<PeriodModel>? periods;
  List<AreaModel>? areas;

  CalendarModel({
    this.id,
    this.day,
    this.date,
    this.periods,
    this.areas,
    this.month,
    this.year,
    this.dayName,
    this.monthName,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarModelToJson(this);
}
