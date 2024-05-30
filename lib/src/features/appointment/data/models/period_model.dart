import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_model.g.dart';

@JsonSerializable()
class PeriodModel {
  int? id;
  int? relationId;
  int? available;
  String? from;
  String? to;

  PeriodModel({
    this.id,
    this.from,
    this.to,
    this.available,
    this.relationId,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodModelToJson(this);
}
