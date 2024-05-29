import 'package:freezed_annotation/freezed_annotation.dart';

import 'ad_model.dart';
import 'item_model.dart';
import 'package_model.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  List<AdModel>? ads;
  List<PackageModel>? categories;
  List<PackageModel>? packages;
  List<PackageModel>? services;
  List<ItemModel>? corporate;
  List<ItemModel>? extras;

  HomeModel({
    this.ads,
    this.categories,
    this.corporate,
    this.extras,
    this.packages,
    this.services,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
