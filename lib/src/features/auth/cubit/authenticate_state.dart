part of 'authenticate_cubit.dart';

@immutable
sealed class AuthenticateState {}

final class AuthenticateInitial extends AuthenticateState {}

class ChangePasswordState extends AuthenticateState {}

class LoginLoadingState extends AuthenticateState {}
class LoginSuccessState extends AuthenticateState {}
class LoginFailureState extends AuthenticateState {}

class CheckEmailLoadingState extends AuthenticateState {}
class CheckEmailSuccessState extends AuthenticateState {}
class CheckEmailFailureState extends AuthenticateState {}

class SendEmailLoadingState extends AuthenticateState {}
class SendEmailSuccessState extends AuthenticateState {}
class SendEmailFailureState extends AuthenticateState {}

class ResetPasswordLoadingState extends AuthenticateState {}
class ResetPasswordSuccessState extends AuthenticateState {}
class ResetPasswordFailureState extends AuthenticateState {}

class DeleteLoadingState extends AuthenticateState {}
class DeleteSuccessState extends AuthenticateState {}
class DeleteFailureState extends AuthenticateState {}

class UpdateLoadingState extends AuthenticateState {}
class UpdateSuccessState extends AuthenticateState {}
class UpdateFailureState extends AuthenticateState {}

class RegisterLoadingState extends AuthenticateState {}
class RegisterSuccessState extends AuthenticateState {}
class RegisterFailureState extends AuthenticateState {}

class FCMLoadingState extends AuthenticateState {}
class FCMSuccessState extends AuthenticateState {}
class FCMFailureState extends AuthenticateState {}

class LogoutLoadingState extends AuthenticateState {}
class LogoutSuccessState extends AuthenticateState {}
class LogoutFailureState extends AuthenticateState {}
