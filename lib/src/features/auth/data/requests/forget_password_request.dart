import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequest {
  final String password;
  @JsonKey(name: "new_password")
  final String newPassword;

  ForgetPasswordRequest({
    required this.password,
    required this.newPassword,
  });

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
}
