import 'package:freezed_annotation/freezed_annotation.dart';

part 'mail_request.g.dart';

@JsonSerializable()
class MailRequest {
  final String email;
  final int? code;

  MailRequest({
    required this.email,
    this.code,
  });

  factory MailRequest.fromJson(Map<String, dynamic> json) =>
      _$MailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MailRequestToJson(this);
}
