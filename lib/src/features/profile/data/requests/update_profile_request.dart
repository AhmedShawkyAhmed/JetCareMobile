import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  String? name;
  String? phone;
  String? email;

  UpdateProfileRequest({
    this.name,
    this.phone,
    this.email,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
