import 'package:freezed_annotation/freezed_annotation.dart';

part 'corporate_request.g.dart';

@JsonSerializable()
class CorporateRequest {
  int userId;
  String name;
  String email;
  String phone;
  int itemId;
  String message;

  CorporateRequest({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.itemId,
    required this.message,
  });

  factory CorporateRequest.fromJson(Map<String, dynamic> json) =>
      _$CorporateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CorporateRequestToJson(this);
}
