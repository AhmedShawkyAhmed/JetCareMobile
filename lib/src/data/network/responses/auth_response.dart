import '../../models/account_model.dart';

class AuthResponse {
  int? status;
  String? message;
  AccountModel? accountModel;

  AuthResponse({this.status, this.message, this.accountModel});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    status: json['status'] ?? 0,
    message: json['message'] ?? "",
    accountModel: json["account"] != null
        ? AccountModel.fromJson(json["account"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message":message,
    "account": accountModel,
  };
}