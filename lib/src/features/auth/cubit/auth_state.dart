part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthenticateInitial extends AuthState {}

class ChangePasswordState extends AuthState {}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {}
class LoginFailureState extends AuthState {}

class CheckEmailLoadingState extends AuthState {}
class CheckEmailSuccessState extends AuthState {}
class CheckEmailFailureState extends AuthState {}

class VerifyEmailLoadingState extends AuthState {}
class VerifyEmailSuccessState extends AuthState {}
class VerifyEmailFailureState extends AuthState {}

class ValidateCodeLoadingState extends AuthState {}
class ValidateCodeSuccessState extends AuthState {}
class ValidateCodeFailureState extends AuthState {}

class ResetPasswordLoadingState extends AuthState {}
class ResetPasswordSuccessState extends AuthState {}
class ResetPasswordFailureState extends AuthState {}

class DeleteLoadingState extends AuthState {}
class DeleteSuccessState extends AuthState {}
class DeleteFailureState extends AuthState {}

class UpdateLoadingState extends AuthState {}
class UpdateSuccessState extends AuthState {}
class UpdateFailureState extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class RegisterFailureState extends AuthState {}

class FCMLoadingState extends AuthState {}
class FCMSuccessState extends AuthState {}
class FCMFailureState extends AuthState {}

class LogoutLoadingState extends AuthState {}
class LogoutSuccessState extends AuthState {}
class LogoutFailureState extends AuthState {}
