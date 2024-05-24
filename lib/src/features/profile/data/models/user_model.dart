import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  num? rate;
  String? role;
  String? token;
  int? active;
  int? archive;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.rate,
    this.role,
    this.token,
    this.active,
    this.archive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
