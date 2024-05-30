import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_model.g.dart';

@JsonSerializable()
class SpaceModel {
  int? id;
  String? from;
  String? to;
  num? price;

  SpaceModel({
    this.id,
    this.from,
    this.to,
    this.price,
  });

  factory SpaceModel.fromJson(Map<String, dynamic> json) =>
      _$SpaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceModelToJson(this);
}
