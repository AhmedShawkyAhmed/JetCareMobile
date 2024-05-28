import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_request.g.dart';

@JsonSerializable()
class SupportRequest {
  String? name;
  String? contact;
  String? subject;
  String? message;

  SupportRequest({
    this.name,
    this.contact,
    this.subject,
    this.message,
  });

  factory SupportRequest.fromJson(Map<String, dynamic> json) =>
      _$SupportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SupportRequestToJson(this);
}