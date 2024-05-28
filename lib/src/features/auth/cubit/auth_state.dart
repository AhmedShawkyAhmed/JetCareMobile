part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthenticateInitial extends AuthState {}

class ChangePassword extends AuthState {}

class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginFailure extends AuthState {}

class CheckEmailLoading extends AuthState {}
class CheckEmailSuccess extends AuthState {}
class CheckEmailFailure extends AuthState {}

class VerifyEmailLoading extends AuthState {}
class VerifyEmailSuccess extends AuthState {}
class VerifyEmailFailure extends AuthState {}

class ValidateCodeLoading extends AuthState {}
class ValidateCodeSuccess extends AuthState {}
class ValidateCodeFailure extends AuthState {}

class ResetPasswordLoading extends AuthState {}
class ResetPasswordSuccess extends AuthState {}
class ResetPasswordFailure extends AuthState {}

class DeleteLoading extends AuthState {}
class DeleteSuccess extends AuthState {}
class DeleteFailure extends AuthState {}

class UpdateLoading extends AuthState {}
class UpdateSuccess extends AuthState {}
class UpdateFailure extends AuthState {}

class RegisterLoading extends AuthState {}
class RegisterSuccess extends AuthState {}
class RegisterFailure extends AuthState {}

class FCMLoading extends AuthState {}
class FCMSuccess extends AuthState {}
class FCMFailure extends AuthState {}

class LogoutLoading extends AuthState {}
class LogoutSuccess extends AuthState {}
class LogoutFailure extends AuthState {}
