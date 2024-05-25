import 'package:jetcare/src/core/utils/enums.dart';

class OtpArguments {
  final String email;
  final String verificationCode;
  final OTPTypes type;

  OtpArguments({
    required this.email,
    required this.verificationCode,
    required this.type,
  });
}
